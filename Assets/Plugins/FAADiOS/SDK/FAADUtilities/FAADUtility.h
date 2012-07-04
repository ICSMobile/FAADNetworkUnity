//
//  FAADUtility.h
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import <Foundation/Foundation.h>


@interface FAADUtility : NSObject {

}

+ (NSString *)getMD5hashCode:(NSString*)concat;
+ (BOOL)internetStatus;
+ (int)checkInternet;
+ (int)getErrorCode:(NSString *)errorString;
+ (NSDictionary *)getErrors;
+ (NSString*)getFormattedSessionData:(NSString*)sessionData;
+ (NSDictionary *)getConnectionFailureError;
@end
