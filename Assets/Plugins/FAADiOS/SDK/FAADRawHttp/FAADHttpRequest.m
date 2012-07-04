//
//  FAADHttpRequest.m
//  FAADNetwork
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved

#import "FAADHttpRequest.h"
#import "FAADCommon.h"


@implementation FAADHttpRequest
@synthesize url = url_;
@synthesize responseData = responseData_;
@synthesize urlConnection = urlConnection_;
@synthesize requestUrl = requestUrl_;
@synthesize request = request_;
@synthesize requestType = requestType_;
@synthesize delegate = delegate_;
@synthesize connectCount = connectCount_;
@synthesize isJson = isJson_;
@synthesize isClosed = isClosed_;



- (void)connectWithURLConnection{
  if(![NSThread isMainThread]){
    [self performSelectorOnMainThread:@selector(connectWithURLConnection) withObject:nil waitUntilDone:NO];
    return;
  }
  
			NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
			self.urlConnection = connection;
            [self performSelector:@selector(triggerTimeOut) withObject:self afterDelay:kFAADRequestTimeOut];
            [connection release];
	
}
- (void)processWebRequestWithURL:(NSString *)url{
	self.url = url;
	if(self.url != nil){
		self.responseData = [NSMutableData data];
		NSURL *nsurl = [[NSURL alloc] initWithString:self.url];
		self.requestUrl = nsurl;
		[nsurl release];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl_];
		self.request = request;
		[request release];
		[self.request setHTTPMethod:requestType_];
		[self connectWithURLConnection];
	}
}





- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData_ setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection	didReceiveData:(NSData *)incrementalData {
	[responseData_ appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [delegate_ requestSucceeded:responseData_];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self closeConnection];
}

- (void)triggerTimeOut{
    [self closeConnection];
}


- (void)closeConnection{
    [urlConnection_ cancel];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(!isClosed_){
       [delegate_ requestFailed];
       isClosed_ = YES;
    }



}
- (void)dealloc{
	[url_ release];
	[responseData_ release];
	[urlConnection_ release];
	[requestUrl_ release];
	[requestType_ release];
	[request_ release];
	[super dealloc];
}

@end
