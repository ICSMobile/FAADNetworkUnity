//
//  FAADOfferClickedWebService.h
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import <Foundation/Foundation.h>
#import "FAADWebRequest.h"
@class FAADHttpRequest;
@interface FAADOfferClickedWebService : FAADWebRequest {
@private
	FAADHttpRequest *faadHttpRequest_; //this object manages all the raw http communication between the SDK and FAADServer
	int currentOfferNumber_;           //the current offer number which is in process of downloading
}

@property (retain,nonatomic) FAADHttpRequest *faadHttpRequest;
@property int currentOfferNumber;

/**
 * sends the request to the server with the offer number/id provided in |offerNumber|
 *
 */
- (void)sendRequestWithOfferNumber:(int)offerNumber;
/**
 *
 * internal class method which initailzes the request.
 */
- (void)sendRequestForOfferClicked;
/**
 * the url creater for the current request with the session token provided in |token| parameter
 *
 */
- (NSString *)createRestFullUrlWithToken:(NSString*)token;

/*
 * this method is called once a new token is obtained from the FAADServer and the request is processed again
 */

- (void)reConnectedForOfferClicked:(NSNotification*)notifyObj;

/*
 * this method processes the issues of invalid token.
 */

- (void)processErrorCode504;

/**
 * default webrequest method
 */
- (void)processWebRequest;

@end
