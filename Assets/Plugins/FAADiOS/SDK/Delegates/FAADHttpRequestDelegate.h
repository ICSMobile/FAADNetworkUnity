//
//  FAADHttpRequestDelegate.h
//  FAADNetwork
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved//

#import <UIKit/UIKit.h>

//A protocol which provides the SDK Webservices to 
//manage their delegates
@protocol FAADHttpRequestDelegate


//Creates the web request with the customized parameters 
//depening on the class implementing the delegate
- (void)processWebRequest;

//Called by the delegate when the current web request is completed
//successfully and parses | responseData | 
- (void)requestSucceeded:(NSData *)responseData;

//Called by the delegate when the current web request fails due to 
//any error
- (void)requestFailed;

@end
