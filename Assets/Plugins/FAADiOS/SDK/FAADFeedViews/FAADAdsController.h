//
//  FAADAdsController.h
//  FAADNetworkSDK
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

#import <UIKit/UIKit.h>

@class FAADNetworkWebService;
@class FAADLandscapeView;
@class FAADPortraitView;
@interface FAADAdsController : UIViewController<UIScrollViewDelegate> {
@private
    FAADLandscapeView *landscapeView_;						// View to display faad campaigns in landscape orientation
    FAADPortraitView *portraitView_;						// View to display faad capmpaigns in portrait orientation
    NSArray *currentAds_;									// this array conatains the current faad campaigns 
    FAADNetworkWebService *networkWebService_;
    BOOL isStatusBar_;										// Boolean to represent either the app have status bar or not
}
@property (retain,nonatomic) IBOutlet FAADLandscapeView *landscapeView;
@property (retain,nonatomic) IBOutlet FAADPortraitView *portraitView;
@property (retain,nonatomic) NSArray *currentAds;
@property (retain,nonatomic) FAADNetworkWebService *networkWebService;
@property BOOL isStatusBar;

/**
 * function which will load the landscape ads view for the appropirate device, iPhone or iPad
 *
 */
- (void)displayLandscapeLayout;

/**
 * function which will be called to display campaigns in landscape orientation 
 *
 */
- (void)displayLandScapeAdsWithStatusBar:(BOOL)statusBar;

/**
 * function which will be called to display campaigns in portrait orientation 
 *
 */
- (void)displayPortraitAdsWithStatusBar:(BOOL)statusBar;

/**
 * this function will request for the faad campaigns
 *
 */
- (void)getNetworkFeeds;

/**
 * this function will process the 504 error
 *
 */
- (void)processErrorCode504;

/**
 * this function will process the 402 error
 *
 */
- (void)processErrorCode402;

/**
 * this function will unregister the faad Ads recieved and failure notifications
 *
 */
- (void)unRegisterForFAADNotifications;

/**
 * this function will register the faad Ads recieved and failure notifications
 *
 */
- (void)registerForFAADNotifications;


/**
 * this function will call the appropirate function to display faad ads
 *
 */
- (void)displayAds;

/**
 * function which will load the portrait ads view for the appropirate device, iPhone or iPad
 *
 */
- (void)displayPortraitLayout;


- (void)processNoAds;

@end