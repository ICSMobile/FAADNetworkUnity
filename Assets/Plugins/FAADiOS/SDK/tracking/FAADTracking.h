//
//  FAADTracking.h
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAADTrackingWebService;
@interface FAADTracking : NSObject {
  NSDate *startTime_;
  NSDate *endTime_;
  NSDate *calculateTime_;
  NSTimeInterval sessionTime_;
    BOOL isActiveSession_;
  FAADTrackingWebService *faadTrackingWebService_;
}

@property (nonatomic,retain) NSDate *startTime;
@property (nonatomic,retain) NSDate *endTime;
@property (nonatomic,retain) NSDate *calculateTime;
@property (nonatomic,retain) FAADTrackingWebService *faadTrackingWebService;
@property NSTimeInterval sessionTime;
@property BOOL isActiveSession;
- (void)registerForDeviceNotifications;
- (void)trackLaunchWhenAppShutsDown;
- (void)trackLaunchWhenAppGoesInBackground;

- (void)trackLaunchWhenAppComeToForeground;

- (void)trackLaunchWhenAppBecomesActive;

- (void)trackWake;
+ (id)sharedManager;
@end
