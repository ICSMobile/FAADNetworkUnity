//
//  FAADConnectWebService.h
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import <Foundation/Foundation.h>
#import "FAADWebRequest.h"

@class FAADHttpRequest;
@interface FAADConnectWebService : FAADWebRequest {
 @private
	FAADHttpRequest *faadHttpRequest_;  //this object manages all the raw http communication between the SDK and FAADServer
	NSString *callBackNotificationName_; //The call back notification name for the service calling the FAADConnect
	NSString *sessionToken_;			  //The current session token for the FAADConnection
	NSDictionary *requestParameters_;	 //The Request paramters dictionary
	int		isCallBack_;				//this checks if we have a call back service or not
	BOOL	isProcessingRequest_;		//To process one request at a  time.
}

@property (retain,nonatomic) FAADHttpRequest *faadHttpRequest;
@property (retain,nonatomic) NSString *callBackNotificationName;
@property (retain,nonatomic) NSString *sessionToken;
@property (retain,nonatomic) NSDictionary *requestParameters;
@property int isCallBack;
@property BOOL isProcessingRequest;

/**
 * function which initiates the http request with the parameters provided in |params|
 *
 */
- (void)sendRequestWithParameter:(NSDictionary*)params;


/**
 * function which the restfull URL format with the parameters provided in |params|
 * 
 */

- (NSString *)createRestFullUrlWithParameters:(NSDictionary *)params;

/**
 * This method reConnects with the FAAD Server as the session token expires
 * after 30 mins. This methods allows the WebServices to connect with Server
 * as the token is received the callBack will be posted and the service can
 * work as required
 *
 */

- (void)connectWithCallBack:(NSString*)callBack;

/**
 * This funcion returns the FAADConnectWebservice shared object instance
 * as this class is now a singleton class.
 *
 */

+ (FAADConnectWebService*)sharedFAADConnectWebService;

/**
 * function which connects with the FAADServer
 *
 **/
- (void)connectWithFAADServer;


-(void)processError500;

@end
