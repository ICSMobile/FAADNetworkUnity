	//
//  FAADLog.m
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import "FAADLog.h"
static FAADLog *logInstance_;

@implementation FAADLog
@synthesize level_;
@synthesize format_;
@synthesize context_;



+ (void)initialize{
	logInstance_ = [[FAADLog alloc] init];
	logInstance_.level_ = kFAADAllLogs;
	logInstance_.format_ = @"[%@] - %@ - %@";

}

- (id)initWithContext:(NSString*)loggingContext{
	if(self = [super init]){
		self.level_ = logInstance_.level_;
		self.format_ = logInstance_.format_;
		self.context_ = loggingContext;
	}
	return self;

}

- (BOOL)levelEnabled:(int)intentLevel{
	return level_ <= intentLevel;
}

- (BOOL)debugEnabled{
	return [self levelEnabled:kFAADDebugLogs];
}



- (void)debug:(NSString *)messageFormat, ...{
	va_list args;
	va_start(args,messageFormat);
	[self logAt:kFAADDebugLogs format:messageFormat args:args];

}

- (void)logAt:(int)intentLevel format:(NSString *)messageFormat args:(va_list)args{
	if([self levelEnabled:intentLevel]){
		NSString *s = [[NSString alloc] initWithFormat:messageFormat arguments:args];
		NSLog(format_,[self nameOfLevel:level_],context_ , s);
		[s release];
		
	}

}


- (NSString*)nameOfLevel:(int)loggingLevel{
	NSString *result = @"UNKNOWN LEVEL";
	switch (loggingLevel) {
		case kFAADAllLogs:
				result = @"FINE";
			break;
		case kFAADDebugLogs:
				result = @"DEBUG";
			break;
		case kFAADInfoLogs:
				result = @"INFO";
			break;
		case kFAADWarnLogs:
				result = @"WARN";
			break;
		case kFAADErrorLogs:
			result = @"ERROR";
			break;
	}
	return result;

}

+ (void)logWithLevel:(int)logLevel forMessage:(NSString*)message{
	
	
	NSLog(@"Log level: %d , and message %@",logLevel,message);
}


- (void)dealloc{
	[format_ release];
	[context_ release];
	[super dealloc];
}




@end
