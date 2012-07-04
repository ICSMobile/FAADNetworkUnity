//
//  FAADTrackingWebService.m
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FAADTrackingWebService.h"
#import "FAADCommon.h"

@implementation FAADTrackingWebService
@synthesize faadHttpRequest = faadHttpRequest_;
@synthesize sessionIds = sessionIds_;
@synthesize database = database_;

- (NSString *)createRestFullUrlWithToken:(NSString*)token{
	NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADTrackingURL];
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@",token];
//	NSLog(@"the url is %@",restfullURL);
  return restfullURL;
  
}
- (NSString*)createRestFullUrlWithSessionData:(NSString*)sessionData{
  NSString *restfullURL = [NSString stringWithFormat:@"%@",kFAADTrackingURL];
	restfullURL = [restfullURL stringByAppendingFormat:@"/%@/%@",[[FAADConnectWebService sharedFAADConnectWebService] sessionToken ],sessionData];
	NSLog(@"the url is %@",restfullURL);
  return restfullURL;
}



- (void)processTracking{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.sessionIds = array;
    [array release];
    FAADDatabase *databaseObject = [[FAADDatabase alloc] init];
    self.database = databaseObject;
    [databaseObject release];
    
    NSString *sessionData = [NSString stringWithString:@""];
    NSArray *sessions = [database_ getSessionsStoredInDB];
    if([sessions count] >= 1){ 
    
        for(int i=0;i < [sessions count] ;i++){
        FAADSessionObject *object = (FAADSessionObject*)[sessions objectAtIndex:i];
            int primaryKey = [object primaryKey];
        [sessionIds_ addObject:[NSNumber numberWithInt:primaryKey]];
        sessionData = [sessionData stringByAppendingFormat:@"%@@",[object sessionText]];
        }
    

        NSString *formattedData = [FAADUtility getFormattedSessionData:sessionData];
        NSString *restfullURL = [self createRestFullUrlWithSessionData:formattedData];
        self.url = [restfullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self processWebRequest];
    }else{
      //  NSLog(@"There are no deffered session to be recorded");
        return;
    }

}


#pragma mark FAADHttpRequestDelegate methods
- (void)processWebRequest{
  if([FAADUtility internetStatus]){ 
    FAADHttpRequest *request = [[FAADHttpRequest alloc] init];
    [request setDelegate:self];
    [request setRequestType:kFAADPOSTRequest];
    [request processWebRequestWithURL:self.url];
   //   NSLog(@"the url is %@",self.url);
    self.faadHttpRequest = request;
    [request release];
  }else {
   // NSLog(@"Please check your Internet connection");
	}
}


- (void)requestSucceeded:(NSData *)responseData{
	NSString *str = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	NSString *rangeString = [NSString stringWithString:str];
	
	if([rangeString rangeOfString:@"error"].location == NSNotFound){
    NSMutableDictionary *sessionStatus = [str JSONValue];
        NSString *status = [sessionStatus objectForKey:@"Status"]; 
        if ([status intValue] == 200){
         //   NSLog(@"Sessions Recorded");
            if(database_ != nil){
                [self updateSessions];
            }else{
                FAADDatabase *databaseObject = [[FAADDatabase alloc] init];
                self.database = databaseObject;
                [databaseObject release];
                
            }
        }
	}else{
		NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSMutableDictionary *responseJson = 	[jsonString JSONValue];
		[jsonString release];
		NSString * responseStatus = [responseJson objectForKey:@"error"];
		if(responseStatus != nil){
			//set the current httprequest to null
			int errorCode = [FAADUtility getErrorCode:responseStatus];
			if(errorCode == 504){
				[self processErrorCode504];
			}
		}
	}
	[str release];
	
}

- (void)processErrorCode504{
	[[FAADConnectWebService sharedFAADConnectWebService] connectWithCallBack:kFAADReConnectForOfferClicked];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reConnectedForOfferClicked:) name:kFAADReConnectForOfferClicked object:nil];
}



- (void)updateSessions{
    if([self.sessionIds count] >= 1){
        for(int i =0; i <[self.sessionIds count]; i++){
            int sessionId = [[self.sessionIds objectAtIndex:i] intValue];
            [self.database updateSessionWithId:sessionId];
            
        }
        
    }

}

- (void)dealloc{
  [faadHttpRequest_ release];
  [sessionIds_ release];
  [database_ release];
  [super dealloc];
  
}
@end
