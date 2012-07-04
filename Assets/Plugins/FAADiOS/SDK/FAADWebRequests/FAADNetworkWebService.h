//
//  FAADNetworkWebService.h
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import <Foundation/Foundation.h>
#import "FAADWebRequest.h"
@class FAADHttpRequest;
@interface FAADNetworkWebService : FAADWebRequest {
@private
	FAADHttpRequest *faadHttpRequest_; //this object manages all the raw http communication between the SDK and FAADServer
	NSString *callBackNotification_;   //The call back notification name for the service calling the FAADConnect 
}
@property (retain,nonatomic) FAADHttpRequest *faadHttpRequest;
@property (retain,nonatomic) NSString *callBackNotification;

/**
 * function which initiates the http request with the token provided in |token|
 *
 */
- (void)sendRequestWithToken:(NSString *)token;


/**
 * function which the restfull URL format with the token provided in |token|
 * 
 */

- (NSString *)createRestFullUrlWithToken:(NSString*)token;


- (void)getNetworkFeedswithCallBack:(NSString*)notifyObject;


/*
 * this method processes the issues of invalid token.
 */

- (void)processErrorCode504;


- (void)reConnectedForNetworkFeed:(NSNotification*)notifyObj;

- (void)processErrorCode402;

@end
