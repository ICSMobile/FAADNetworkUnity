//
//  FAADWebRequest.m
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import "FAADWebRequest.h"


@implementation FAADWebRequest
@synthesize url = url_;

// Default over ride method for super class
- (id)init{
	return [self initWithDefaultUrl];
}

- (id)initWithDefaultUrl{
	if ((self = [super init])){
		//url_ = [[NSString alloc] initWithString:kFAADConnectURL];
	}
	return self;
}

- (void)processWebRequest{
}


- (void)requestSucceeded:(NSData *)responseData{
	
}

- (void)requestFailed{
	
}

- (void)dealloc{
	[url_ release];
	[super dealloc];
}
@end
