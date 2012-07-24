//
//  FAADConnectWebService.m
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import "FAADConnectWebService.h"
#import "FAADCommon.h"


@implementation FAADConnectWebService
static FAADConnectWebService *sharedConnectWebService_ = nil;

@synthesize faadHttpRequest = faadHttpRequest_;
@synthesize callBackNotificationName = callBackNotificationName_;
@synthesize sessionToken = sessionToken_;
@synthesize requestParameters = requestParameters_;
@synthesize isProcessingRequest = isProcessingRequest_;
@synthesize isCallBack = isCallBack_;



+ (FAADConnectWebService*)sharedFAADConnectWebService{
	@synchronized([FAADConnectWebService class]){
		if(!sharedConnectWebService_){
			[[self alloc] init];
		}
	}
	return sharedConnectWebService_;
}

+(id)alloc{
	@synchronized([FAADConnectWebService class]){
		NSAssert(sharedConnectWebService_ == nil,@"Attempt to allocate a second instance of a singleton");
		sharedConnectWebService_ = [super alloc];
		return sharedConnectWebService_;
	}
	return nil;
}


-(id)init{
	self = [super init];
	if(self != nil){
	}
	return self;
}



#pragma mark  initMethods
- (void)sendRequestWithParameter:(NSDictionary*)params{
	self.requestParameters = params;
	self.url = [self createRestFullUrlWithParameters:[self requestParameters]];
	[self processWebRequest];
}

- (NSString *)createRestFullUrlWithParameters:(NSDictionary *)params{
	
	NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADConnectURL];
    
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@/%@/%d/%@?%@=%@&%@=%@&%@=%@&%@=%@",[params objectForKey:@"udid"],
                   [params objectForKey:@"appIntegrationKey"],[[params objectForKey:@"isBeta"] intValue],[params objectForKey:@"hashCode"],kFAADCountryCode,[params objectForKey:kFAADCountryCode],kFAADVersion,kFAADLibraryVersion,kMacAddress,[params objectForKey:kMacAddress],kDeviceType,[params objectForKey:kDeviceType]];
	NSLog(@"the connect url is %@",restfullURL);
	return restfullURL;

}


#pragma mark FAADHttpRequestDelegate methods
- (void)processWebRequest{
	isCallBack_ = 0;
	[self connectWithFAADServer];
}

- (void)connectWithFAADServer{
	
	if([FAADUtility internetStatus]){ 
		FAADHttpRequest *request = [[FAADHttpRequest alloc] init];
		[request setDelegate:self];
		[request setRequestType:kFAADPOSTRequest];
		[request processWebRequestWithURL:[self createRestFullUrlWithParameters:[self requestParameters]]];
		self.faadHttpRequest = request;
		self.isProcessingRequest = TRUE;
		[request release];
	}else {
		self.isProcessingRequest = FALSE;
	//NSLog(@"Please check you internet connection here");
		[[NSNotificationCenter defaultCenter] postNotificationName:kFAADTokenFailed object:nil];
        if(isCallBack_ == 1){
			isCallBack_ = 0;
			[[NSNotificationCenter defaultCenter] postNotificationName:callBackNotificationName_ object:[FAADUtility getConnectionFailureError]];
		}
	}
	
	
}
#pragma mark Delegate method 

- (void)requestSucceeded:(NSData *)responseData{
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSMutableDictionary *responseDictionary = 	[jsonString JSONValue];
    NSLog(@"the response dictionary is %@",responseDictionary);
	[jsonString release];
	NSString * responseStatus = [responseDictionary objectForKey:kFAADToken];
	
	if(responseStatus != nil){
		isProcessingRequest_ = FALSE;
		[self setSessionToken:responseStatus];
		if(isCallBack_ == 1){
			isCallBack_ = 0;
			[[NSNotificationCenter defaultCenter] postNotificationName:callBackNotificationName_ object:responseDictionary];
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:kFAADConnectSuccessfullNotification object:nil];
		
	}else {
		responseStatus = [responseDictionary objectForKey:kFAADError];
		int errorCode = [FAADUtility getErrorCode:responseStatus];
		if(errorCode == 401){
            [self requestFailed];
		}else if(errorCode == 500){
            [self processError500];
        }
    
	}
}

- (void)processError500{
 // NSLog(@"Server Error Occured");
    if(isCallBack_ == 1){
        isCallBack_ = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:callBackNotificationName_ object:[FAADUtility getConnectionFailureError]];
    }

}

- (void)processError401{
  //  NSLog(@"You are using invalid application Keys. Please check your keys and try again");
}
- (void)requestFailed{
    if(isCallBack_ == 1){
        isCallBack_ = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:callBackNotificationName_ object:[FAADUtility getConnectionFailureError]];
    }
		[[NSNotificationCenter defaultCenter] postNotificationName:kFAADConnectFailureNotification object:nil];
}																														 


- (void)connectWithCallBack:(NSString*)callBack{
	isCallBack_ = 1;
	[self setCallBackNotificationName:callBack];
	[self connectWithFAADServer];
}

- (void)dealloc{
	[faadHttpRequest_ release];
	[callBackNotificationName_ release];
	[sessionToken_ release];
	[requestParameters_ release];
	[sharedConnectWebService_ release];
	[super dealloc];
}


@end
