//
//  FAADHttpRequest.h
//  FAADNetwork
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved


#define kFAADReconnectCount 2

#import <Foundation/Foundation.h>
#import "FAADHttpRequestDelegate.h"

/**
 * FAADHttpRequest class manages the direct communication with the
 * FAADServer and delegates the response back to the corresponding delegate
 */

@interface FAADHttpRequest : NSObject {
@private;	
	NSString *url_;													//the url in string format
	NSMutableData *responseData_;						//the response data
	NSURLConnection *urlConnection_;				//the NSURLConnection to manage the url connections
	NSURL *requestUrl_;											//created from the string format of the URL to work with the url Request
	NSMutableURLRequest *request_;					//the raw request which handles all the communications
	NSString *requestType_;									//the request type either "GET" or "POST"
	int connectCount_;											//the request retry before prompting the user for error
	int isJson_;														//the request type either JSON or html format
	id<FAADHttpRequestDelegate> delegate_;	//the delegate which calls the FAADHttpRequest
    BOOL isClosed_;
}

@property (copy,nonatomic) NSString *url;
@property (retain,nonatomic) NSData *responseData;
@property (retain,nonatomic) NSURLConnection *urlConnection;
@property (retain,nonatomic) NSURL *requestUrl;
@property (retain,nonatomic) NSMutableURLRequest *request;
@property (copy,nonatomic)	 NSString *requestType;
@property (assign) id<FAADHttpRequestDelegate> delegate;
@property int connectCount;
@property int isJson;
@property BOOL isClosed;
/**
 *	function wich initializes the process of communication with the FAADServer
 *
 */

- (void)processWebRequestWithURL:(NSString *)url;

/**
 *	function which allocates the NSURL connection to proccess the request with FAADSever
 *
 */

- (void)connectWithURLConnection;

- (void)triggerTimeOut;
- (void)closeConnection;
@end
