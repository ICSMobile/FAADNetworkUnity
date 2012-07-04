//
//  FAADPortraitView.h
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
#import <UIKit/UIKit.h>

@class FAADOfferClickedWebService;
@interface FAADPortraitView : UIView<UIScrollViewDelegate> {
	UIButton *closeButton_;									//Close(X) button which will close the Ads view
	UIButton *downloadButton_;								//Download/Install button which will let the user to download app
	UIScrollView *adsScrollView_;							//Scroll view to show the ads
	UIActivityIndicatorView *spinner_;						//Spinner to indicate the user that ads are loading
	UIPageControl *pageControl_;							// Page controller for the Ads scroll view
  NSArray *currentAds_;										// Array which will contain the campaign list
  FAADOfferClickedWebService *offerClickedWebService_;
  BOOL isStatusBar_;										// Boolean variable to represent either the app have status bar or not
  UIView *containerView_;
    
    UIButton * forwardButton_;
    UIButton * backButton_;
}

@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIButton *downloadButton;
@property (nonatomic, retain) UIScrollView *adsScrollView;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSArray *currentAds;
@property (nonatomic, retain) FAADOfferClickedWebService *offerClickedWebService;
@property (nonatomic, retain) UIView *containerView;
@property BOOL isStatusBar;
@property (nonatomic, retain) UIButton *forwardButton;
@property (nonatomic, retain) UIButton *backButton;


/**
 * function which will close the Ads view when close(X) button get pressed
 *
 */
- (void)closeView;

/**
 * function which initiate the request to download application when Download button get pressed
 *
 */
- (void)download;

/**
 * function which will load the provided campaigns in the scroll view
 *
 */
- (void)displayAds:(NSArray*)currentAds;

/**
 * function which will decide the view if for iPhone or iPad and the set the layout accordingly
 * This will also manage the view by considering the provided info that status bar is hidden or visible in the application
 */
- (void)displayLayoutWithStatusBar:(BOOL)statusBar;

/**
 * function which starts the download of application against the provided offerId.
 *
 */
- (void)downloadOfferForId:(int)offerId;

/**
 * function which will set the layout of View for iPhone and will add its components like the logo, background, scroll view etc.
 *
 */
- (void)setiPhoneLayout;

/**
 * function which will set the layout of View for iPad and will add its components like the logo, background, scroll view etc.
 *
 */
- (void)setiPadLayout;

/**
 * function which will load the campaigns in scroll view for iPad
 *
 */
- (void)loadAdsIniPad;

/**
 * function which will load the campaigns in scroll view for iPhone
 *
 */
- (void)loadAdsIniPhone;

/**
 * function which will remove the portrait view from root window
 *
 */
- (void)remove;

/**
 *function to update ad view on forward or back button click
 *
 *
 */
-(void)updateViewOnForwardBackbutton:(UIButton*)sender;

@end
