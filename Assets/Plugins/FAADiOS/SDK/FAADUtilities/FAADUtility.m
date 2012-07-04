//
//  FAADUtility.m
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved//

#import "FAADUtility.h"
#import "FAADReachability.h"
#import <CommonCrypto/CommonDigest.h>

@implementation FAADUtility

+ (NSString *)getMD5hashCode:(NSString*)concat{
	
	const char *concat_str = [concat UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(concat_str, strlen(concat_str), result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < 16; i++)
		[hash appendFormat:@"%02X", result[i]];
	
	return [hash lowercaseString];
}

+ (NSDictionary *)getConnectionFailureError{
    NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"904",@"error",nil];
	return [responseDictionary autorelease];
}

+ (NSDictionary *)getErrors{
	
	NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"800",@"error",@"0",@"Credit",nil];
	return [responseDictionary autorelease];
	
}
+ (BOOL)internetStatus{
	int error = [self checkInternet];
	if(error == 0){
		return FALSE;
	}else{
		return TRUE;
	}
}

+ (int)checkInternet{
	int error=0;
	if ( [[FAADReachability sharedReachability] internetConnectionStatus] == NotReachable ){
		error = 0;
	}
	if ( [[FAADReachability sharedReachability] internetConnectionStatus] == 1 ){
		error = 1;
	}
	if ( [[FAADReachability sharedReachability] internetConnectionStatus] == 2 ){
		error = 2;
	}
	return error;
}


+ (int)getErrorCode:(NSString *)errorString{
	NSArray *errorAndCode = [errorString componentsSeparatedByString:@" "];
	NSString *errorCode = [errorAndCode objectAtIndex:0];
	return [errorCode intValue];
}


+ (NSString*)getFormattedSessionData:(NSString*)sessionData{
//  2011-07-06 12:46:57/2011-07-06 12:47:08/0
    //split by space;
    NSString *returnString= [NSString stringWithString:@""];
    NSArray *singleSessions = [sessionData componentsSeparatedByString:@"@"];
    NSString *startTime = [NSString stringWithString:@""];
    NSString *endTime = [NSString stringWithString:@""];
    NSString *minutes = [NSString stringWithString:@""];
    if([singleSessions count] -1 > 1){
        int i =1;  
        for(;i<[singleSessions count] -1;i++){
        NSString *session = [singleSessions objectAtIndex:i];
       // NSLog(@"the session is %@",session);
        NSArray *split_session = [session componentsSeparatedByString:@"/"];
        startTime =[startTime stringByAppendingFormat:@"%@,",[split_session objectAtIndex:0]];
        endTime = [endTime stringByAppendingFormat:@"%@,",[split_session objectAtIndex:1]];
        minutes = [minutes stringByAppendingFormat:@"%@,",[split_session objectAtIndex:2]];
        }
       // NSLog(@"the string format is %@/%@/%@/%@",[singleSessions objectAtIndex:0],startTime,endTime,minutes);
        return [NSString stringWithFormat:@"%@/%@/%@/%@",[singleSessions objectAtIndex:0],startTime,endTime,minutes];
    }else if([singleSessions count] -1 == 1){
       // NSLog(@"the single session is %@",[singleSessions objectAtIndex:0]);
        returnString = [NSString stringWithFormat:@"%@",[singleSessions objectAtIndex:0]];
       // NSLog(@"the return string is %@",returnString);
        return returnString;
    }
    return NULL;
}

@end
