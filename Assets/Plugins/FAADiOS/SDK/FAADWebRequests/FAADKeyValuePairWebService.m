//
//  FAADKeyValuePairWebService.m
//  FAADSilver
//
//  Created by Asad Rehman on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FAADKeyValuePairWebService.h"
#import "FAADCommon.h"

@implementation FAADKeyValuePairWebService
@synthesize faadHttpRequest = faadHttpRequest_;
@synthesize callBackNotification = callBackNotification_;
#pragma mark init Methods

- (void)sendRequestForKeyValuePairWithToken:(NSString *)token{
	self.url = [self createRestFullUrlWithToken:token];
	[self processWebRequest];
}

- (NSString *)createRestFullUrlWithToken:(NSString*)token{
	NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADKeyValueServiceURL];
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@",token];
     NSLog(@"the  key value url is %@",restfullURL);
	return restfullURL;
}


#pragma mark FAADHttpRequestDelegate methods
- (void)processWebRequest{
    if([FAADUtility internetStatus]){ 
        FAADHttpRequest *faadHttpRequest = [[FAADHttpRequest alloc] init];
        [faadHttpRequest setDelegate:self];
        [faadHttpRequest setRequestType:kFAADPOSTRequest];
        [faadHttpRequest processWebRequestWithURL:self.url];
        faadHttpRequest_ = faadHttpRequest;
        [faadHttpRequest release];
    }else{
        NSLog(@"Please check your internet connections ");
        [self requestFailed];
        
    }
}


- (void)requestSucceeded:(NSData *)responseData{
	//[[NSNotificationCenter defaultCenter] postNotificationName:kFAADKVReceivedNotification object:responseData];
   // NSLog(@"the response is %@",responseData);
    if(callBackNotification_ != nil){
        NSString *str = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        NSString *rangeString = [NSString stringWithString:str];
       NSLog(@"range String %@",rangeString);
        if([rangeString rangeOfString:@"error"].location == NSNotFound){
        //    NSDictionary *adsArray = [str	JSONValue];    
      //   NSLog(@"%@",adsArray);
          [[NSNotificationCenter defaultCenter] postNotificationName:callBackNotification_ object:str];
        }else{
            NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSMutableDictionary *responseJson = 	[jsonString JSONValue];
            [jsonString release];
            NSString * responseStatus = [responseJson objectForKey:@"error"];
            if(responseStatus != nil){
                //set the current httprequest to null
                int errorCode = [FAADUtility getErrorCode:responseStatus];
                if(errorCode == 504){
                    [self processErrorCode504];
                }
                
            }
            
            [str release];
        }
    }
}

- (void)requestFailed{
//	[[NSNotificationCenter defaultCenter] postNotificationName:kFAADAdsFailureNotification object:nil];
    NSLog(@"Request Failed");
    [[NSNotificationCenter defaultCenter] postNotificationName:callBackNotification_ object:nil];
}																											
- (void)getKeyValuePairswithCallBack:(NSString*)callBack{
    callBackNotification_ = callBack;
    if([[FAADConnectWebService sharedFAADConnectWebService] sessionToken] != nil){
        [self sendRequestForKeyValuePairWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
    }else{
        NSLog(@"FAADNetwork Authentication error:  No token found for current session.");
        
    }
}


- (void)processErrorCode504{
	[[FAADConnectWebService sharedFAADConnectWebService] connectWithCallBack:kFAADReConnectForKeyValuePairs];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reConnectedForNetworkFeed:) name:kFAADReConnectForKeyValuePairs object:nil];
}

- (void)reConnectedForNetworkFeed:(NSNotification*)notifyObj{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADReConnectForKeyValuePairs object:nil];
    [self sendRequestForKeyValuePairWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
}




- (void)dealloc{
    [faadHttpRequest_ release];
    [callBackNotification_ release];
    [super dealloc];
}
@end
