//
//  FAADWebRequest.h
//  FAADNetwork
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//
#import <Foundation/Foundation.h>
#import "FAADHttpRequestDelegate.h"

//A parent class for all the webrequests used with in the 
//SDK and implements the FAADHttpRequest Delegate
@interface FAADWebRequest : NSObject<FAADHttpRequestDelegate> {
@private
	NSString *url_;
}

@property (copy,nonatomic) NSString *url;

//initialzes the default object
- (id)init;

//initialzes the the url property with the default url for the web request
- (id)initWithDefaultUrl;

@end
