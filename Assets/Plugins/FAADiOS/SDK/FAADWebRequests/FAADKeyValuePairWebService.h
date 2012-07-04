//
//  FAADKeyValuePairWebService.h
//  FAADSilver
//
//  Created by Asad Rehman on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAADWebRequest.h"
@class FAADHttpRequest;

@interface FAADKeyValuePairWebService :FAADWebRequest {
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
- (void)sendRequestForKeyValuePairWithToken:(NSString *)token;


/**
 * function which the restfull URL format with the token provided in |token|
 * 
 */

- (NSString *)createRestFullUrlWithToken:(NSString*)token;


- (void)getKeyValuePairswithCallBack:(NSString*)callBack;


/*
 * this method processes the issues of invalid token.
 */

- (void)processErrorCode504;


- (void)reConnectedForNetworkFeed:(NSNotification*)notifyObj;


@end

