//
//  FAADTracking.m
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FAADTracking.h"
#import "FAADCommon.h"
static FAADTracking *sharedTracking_ = nil;
@implementation FAADTracking
@synthesize startTime = startTime_;
@synthesize endTime = endTime_;
@synthesize calculateTime = calculateTime_;
@synthesize sessionTime = sessionTime_;
@synthesize faadTrackingWebService = faadTrackingWebService_;
@synthesize isActiveSession = isActiveSession_;
- (void)registerForDeviceNotifications{
    //register for notification when the faad network is connected
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FAADProcessTracking:) name:kFAADProcessTrackingNotification object:nil];
  // Register for notification when the app shuts down
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackLaunchWhenAppShutsDown) name:UIApplicationWillTerminateNotification object:nil];
  
  // On iOS 4.0+ only, listen for background notification
  if(&UIApplicationDidEnterBackgroundNotification != nil)
  {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackLaunchWhenAppGoesInBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
  }
  
  // On iOS 4.0+ only, listen for foreground notification
  if(&UIApplicationWillEnterForegroundNotification != nil)
  {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackLaunchWhenAppComeToForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
  }
  
  // listen for sleep/interrupt calls
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackLaunchWhenAppGoesInBackground) name:UIApplicationWillResignActiveNotification object:nil];
  
  // listen for wake
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackLaunchWhenAppBecomesActive) name:UIApplicationDidBecomeActiveNotification object:nil];
 
    [self trackLaunchWhenAppBecomesActive];
  //  self.isActiveSession = YES;
    
}

+ (id)sharedManager{
    
    if(sharedTracking_ == nil){
        sharedTracking_ = [[FAADTracking alloc] init];
    }
    return sharedTracking_;
}

- (id)init{
    if((self = [super init])){
        faadTrackingWebService_ = [[FAADTrackingWebService alloc] init];
        isActiveSession_ = NO;
    }
    return self;
}

- (void)trackLaunchWhenAppShutsDown{
 // NSLog(@"App Shut Down");
    NSTimeInterval secs = -1 * [self.calculateTime timeIntervalSinceNow];
   // NSLog(@"the time interval is %f",secs);
    sessionTime_ = sessionTime_ + secs;
   // NSLog(@"the total time interval is %f",sessionTime_);
   // NSLog(@"app in background");
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *startDateString = [dateFormat stringFromDate:startTime_];
  //  NSLog(@"date: %@", startDateString);
    self.endTime = [NSDate date];
    NSString *endDateString = [dateFormat stringFromDate:endTime_];
    
    [dateFormat release];
    
    //  float minutes = ( sessionTime_ / 60); 
    
    
    NSString *data = [NSString stringWithFormat:@"%@/%@/%0.f",startDateString,endDateString,sessionTime_];
    FAADDatabase *database = [[FAADDatabase alloc] init];
    int result =  [database storeSessionInDatabase:data];
    if(result > 0){
      //  NSLog(@"Session stored");
        self.sessionTime = 0;
    }
    [database release];


}

- (void)trackLaunchWhenAppGoesInBackground{
  
  NSTimeInterval secs = -1 * [self.calculateTime timeIntervalSinceNow];
//  NSLog(@"the time interval is %f",secs);
  sessionTime_ = sessionTime_ + secs;
 // NSLog(@"the total time interval is %f",sessionTime_);
 // NSLog(@"app in background");
  
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
  NSString *startDateString = [dateFormat stringFromDate:startTime_];
 // NSLog(@"date: %@", startDateString);
  self.endTime = [NSDate date];
  NSString *endDateString = [dateFormat stringFromDate:endTime_];
  
  [dateFormat release];
 
//  float minutes = ( sessionTime_ / 60); 
 
  
  NSString *data = [NSString stringWithFormat:@"%@/%@/%0.f",startDateString,endDateString,sessionTime_];
  FAADDatabase *database = [[FAADDatabase alloc] init];
  int result =  [database storeSessionInDatabase:data];
  if(result > 0){
    //NSLog(@"Session stored");
      self.sessionTime = 0;
  }
  [database release];
}

- (void)trackLaunchWhenAppComeToForeground{
  //NSLog(@"App came to foreground");
  self.calculateTime = [NSDate date];
  

}

- (void)trackLaunchWhenAppBecomesActive{
  //NSLog(@"app became active");
 // if(!isActiveSession_){
  self.startTime = [NSDate date];
    //  isActiveSession_ = YES;
      self.calculateTime = self.startTime;

  //}
   
}

- (void)trackWake{
  //NSLog(@"Track wake");
}
- (void)FAADProcessTracking:(NSNotification*)notifyObject{
}
- (void)dealloc{
    [faadTrackingWebService_ release];
    [sharedTracking_ dealloc];
    [super dealloc];
}

@end
