//
//  FAADTrackingWebService.h
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAADWebRequest.h"
@class FAADHttpRequest;
@class FAADDatabase;
@interface FAADTrackingWebService : FAADWebRequest {
  @private
	FAADHttpRequest *faadHttpRequest_; //this object manages all the raw http communication between the SDK and FAADServer
    NSMutableArray *sessionIds_;
    FAADDatabase *database_;
}

@property (retain,nonatomic) FAADHttpRequest *faadHttpRequest;
@property (retain,nonatomic) NSMutableArray *sessionIds;
@property (retain,nonatomic) FAADDatabase *database;
/**
 * the url creater for the current request with the session token provided in |token| parameter
 *
 */
- (NSString *)createRestFullUrlWithToken:(NSString*)token;


/*
 * this method processes the issues of invalid token.
 */

- (void)processErrorCode504;

/**
 * default webrequest method
 */
- (void)processWebRequest;


- (NSString*)createRestFullUrlWithSessionData:(NSString*)sessionData;
- (void)processTracking;
- (void)updateSessions;
@end

