//
//  FAADNetworkWebService.m
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import "FAADNetworkWebService.h"
#import "FAADCommon.h"
@implementation FAADNetworkWebService
@synthesize faadHttpRequest = faadHttpRequest_;
@synthesize callBackNotification = callBackNotification_;
#pragma mark init Methods

- (void)sendRequestWithToken:(NSString *)token{
	self.url = [self createRestFullUrlWithToken:token];
	[self processWebRequest];
}

- (NSString *)createRestFullUrlWithToken:(NSString*)token{
	NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADNetworkServiceURL];
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@",token];
    NSLog(@"the url is %@",restfullURL);
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
  //  NSLog(@"Please check your internet connections ");
      [self requestFailed];
  
  }
}


- (void)requestSucceeded:(NSData *)responseData{
	if(callBackNotification_ != nil){
        NSString *str = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        if([str rangeOfString:kFAADTokenErrorString].location == NSNotFound){
            NSArray *adsArray = [str JSONValue];
            if([adsArray count] > 0){
                [[NSNotificationCenter defaultCenter] postNotificationName:callBackNotification_ object:adsArray];
            }else{
                NSLog(@"No Ads");
            }
        }else{
            NSDictionary *dict = [str JSONValue];
            if(dict != nil){
                NSString *responseStatus = [dict objectForKey:@"error"];
                int errorCode = [FAADUtility getErrorCode:responseStatus];
                if(errorCode == 504){
                    [self processErrorCode504];
                }else if(errorCode == 402){
                    [self processErrorCode402];
                }
            }
        }
        [str release];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kFAADAdsReceivedNotification object:responseData];
    }
    
}

- (void)requestFailed{
	[[NSNotificationCenter defaultCenter] postNotificationName:kFAADAdsFailureNotification object:nil];
}																											
- (void)getNetworkFeedswithCallBack:(NSString*)callback{
    callBackNotification_ = callback;
		if([[FAADConnectWebService sharedFAADConnectWebService] sessionToken] != nil){
    [self sendRequestWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
		}else{
	//		NSLog(@"FAADNetwork Authentication error:  No token found for current session.");
			
		}
}


- (void)processErrorCode504{
	[[FAADConnectWebService sharedFAADConnectWebService] connectWithCallBack:kFAADReConnectForNetworkFeeds];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reConnectedForNetworkFeed:) name:kFAADReConnectForNetworkFeeds object:nil];
}

- (void)processErrorCode402{
}

- (void)reConnectedForNetworkFeed:(NSNotification*)notifyObj{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADReConnectForNetworkFeeds object:nil];
  [self sendRequestWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
}




- (void)dealloc{
  [faadHttpRequest_ release];
  [callBackNotification_ release];
  [super dealloc];
}

@end
