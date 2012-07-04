//
//  FAADLog.h
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved//

#import <Foundation/Foundation.h>

#define kFAADAllLogs		1
#define kFAADDebugLogs  2
#define kFAADInfoLogs		3
#define kFAADWarnLogs		4
#define kFAADErrorLogs	5

@interface FAADLog : NSObject {
	int level_;
	NSString *context_;
	NSString *format_;
}



@property (retain,nonatomic) NSString *context_;
@property (retain,nonatomic) NSString *format_;
@property int level_;



+ (void)initialize;
- (id)initWithContext:(NSString*)loggingContext;
- (BOOL)levelEnabled:(int)intentLevel;
- (BOOL)debugEnabled;
- (void)debug:(NSString *)messageFormat, ...;
- (void)logAt:(int)intentLevel format:(NSString *)messageFormat args:(va_list)args;
- (NSString*)nameOfLevel:(int)loggingLevel;
+ (void)logWithLevel:(int)logLevel forMessage:(NSString*)message;
@end
