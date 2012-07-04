//
//  FAADOfferClickedWebService.m
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import "FAADOfferClickedWebService.h"
#import "FAADCommon.h"

@implementation FAADOfferClickedWebService
@synthesize faadHttpRequest = faadHttpRequest_;
@synthesize currentOfferNumber = currentOfferNumber_;


- (void)sendRequestWithOfferNumber:(int)offerNumber{
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reConnectedForOfferClicked:) name:kFAADReConnectForOfferClicked object:nil];
	[self setCurrentOfferNumber:offerNumber];
	[self sendRequestForOfferClicked];
}

- (void)sendRequestForOfferClicked{
	self.url = [self createRestFullUrlWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
	[self processWebRequest];
    
}
- (NSString *)createRestFullUrlWithToken:(NSString*)token{
	NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADOfferClickedURL];
	
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@/%d",token,[self currentOfferNumber]];
	return restfullURL;
  
}


#pragma mark FAADHttpRequestDelegate methods
- (void)processWebRequest{
    if([FAADUtility internetStatus]){ 
        FAADHttpRequest *request = [[FAADHttpRequest alloc] init];
        [request setDelegate:self];
        [request setRequestType:kFAADGETRequest];
        [request processWebRequestWithURL:self.url];
        self.faadHttpRequest = request;
        [request release];
    }else {
     //   NSLog(@"Please check your Internet connection");
	}
}


- (void)requestSucceeded:(NSData *)responseData{
	NSString *str = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	NSLog(@"the click response is %@",str);
    NSString *rangeString = [NSString stringWithString:str];
	
	if([rangeString rangeOfString:@"error"].location == NSNotFound){
    NSMutableDictionary *appURL = [str JSONValue];
    NSURL *url = [NSURL URLWithString:[appURL objectForKey:@"appStoreUrl"]];
   [[UIApplication sharedApplication] openURL:url];
        //open the url in the application
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
	}
	[str release];
	
}

- (void)requestFailed{
	//NSLog(@"Unable to Download the Application. Please check you internet connection");
}	

- (void)processErrorCode504{
	[[FAADConnectWebService sharedFAADConnectWebService] connectWithCallBack:kFAADReConnectForOfferClicked];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reConnectedForOfferClicked:) name:kFAADReConnectForOfferClicked object:nil];
}

- (void)reConnectedForOfferClicked:(NSNotification*)notifyObj{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADReConnectForOfferClicked object:nil];
  [self sendRequestForOfferClicked];
  
}


- (void)dealloc{
  [faadHttpRequest_ release];
  [super dealloc];
    
}
@end
