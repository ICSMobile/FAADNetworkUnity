//
//  FAADCommon.h
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//




/**
 * 
 *  All the notification constants and string constants for FAADNetwork
 * 
 */


#define kDeviceId                               @"udid"
#define kAppIntegrationKey                      @"appIntegrationKey"
#define kAppSecertKey                           @"appSecretKey"
#define kDeviceType                             @"deviceType"
#define kDeviceOS                               @"deviceOS"
#define kFAADLibraryVersion                     @"2.0"
#define kFAADisBeta                             @"isBeta"
#define kBuildNumber                            @"2.0-Beta"
#define kOSName                                 @"OSType"
#define kOSValue                                @"iPhone"
#define kHashCode                               @"hashCode"
#define kMacAddress                             @"MacAddress"
#define kFAADConnectSuccessfullNotification		@"FAADConnected"
#define kFAADConnectFailureNotification         @"FAADFailedToConnect"
#define kFAADAdsReceivedNotification            @"FAADAdsReceived"
#define kFAADAdsFailureNotification             @"FAADAdsFailed"
#define kFAADReConnectNotification              @"reConnected"
#define kFAADErrorNotification                  @"error"
#define kFAADReconnectedForAdsNotification      @"faadReconnectedForAds"
#define kFAADReConnectForOfferClicked           @"faadReconnectedForOfferClicked"
#define kFAADProcessTrackingNotification        @"faadProcessTrackingNotification"
#define	kFAADToken                              @"token"
#define kFAADAmount                             @"amount"
#define kFAADCredit                             @"Credit"
#define kFAADConnectStatus                      @"Status"
#define kFAADTokenFound                         @"FaadTokenFound"
#define kFAADTokenFailed                        @"FAADTOKENFAILED"
#define kFAADGETRequest                         @"GET"
#define kFAADPOSTRequest                        @"POST"
#define kFAADCampaignName                       @"name"
#define kFAADCampaignDescription                @"description"
#define kFAADCampaignId                         @"campaignId"
#define kFAADApplicationImageURL                @"applicationImageURL"
#define kFAADError                              @"error"
#define kFAADReConnectForNetworkFeeds           @"reconnectedForNetworkFeeds"
#define kFAADCountryCode                        @"locale"
#define kFAADVersion                            @"version"
#define kFAADFeedViewClosed                     @"FEEDViewClosed"
#define kSplashKitKeyValuePairs                 @"keyValuePairsReceivedInKit"
#define kFAADRequestTimeOut                   15.0
#define isStaging           0
#define kFAADTokenErrorString                   @"504 Authentication token error"

#define kFAADReConnectForKeyValuePairs          @"reconnectedForKeyValuePairs"
#define degreesToRadian(x) (M_PI * x / 180.0)

#define heightOffset 10

#define iconInitialX 70
#define iconInitialY 20
#define appNameX   115
#define appNameY    10
#define appDescX	 115
#define appDescY		30
#define deltaX		480
#define appIconWidth 47
#define appIconHeight 47
#define appTitleWidth 200
#define appTitleHeight 150
#define appDescWidth 300

#define iconInitialXPortrait 50
#define iconInitialYPortrait 30
#define appNameXPortrait  95
#define appNameYPortrait  20
#define appDescXPortrait  95
#define appDescYPortrait  35
#define deltaXPortrait		320
#define appIconWidthPortrait 47
#define appIconHeightPortrait 47
#define appTitleWidthPortrait 200
#define appTitleHeightPortait 150
#define appDescWidthPortrait  200
#define appDescHeightPortrait 500

#define backgroundXiPhoneLandscape          0
#define backgroundYiPhoneLandscape          0
#define backgroundWidthiPhoneLandscape		480
#define backgroundHeightiPhoneLandscape     250
#define faadLogoXiPhoneLandscape            5
#define faadLogoYiPhoneLandscape            9
#define faadLogoWidthiPhoneLandscape		158
#define faadlogoHeightiPhoneLandscape       70
#define closeButtonXiPhoneLandscape			409
#define closeButtonYiPhoneLandscape			15
#define closeButtonWidthiPhoneLandscape		47
#define closeButtonHeightiPhoneLandscape	47
#define adsScrollViewXiPhoneLandscape       0
#define adsScrollViewYiPhoneLandscape		68
#define adsScrollViewWidthiPhoneLandscape	480
#define adsScrollViewHeightiPhoneLandscape	130
#define pageControllerXiPhoneLandscape		201
//salman
#define pageControlContainerViewX 240
//
#define pageControllerYiPhoneLandscape		180
#define pageControllerWidthiPhoneLandscape	150
//addition
#define pageControlCenerX 75
//
#define pageControllerHeightiPhoneLandscape 36
#define downloadButtonXiPhoneLandscape		192
#define downloadButtonYiPhoneLandscape		203
#define downloadButtonWidthiPhoneLandscape	97
#define downloadButtonHeightiPhoneLandscape 97

#define backgroundXiPhonePortrait			-3
#define backgroundYiPhonePortrait			0
#define backgroundWidthiPhonePortrait		326
#define backgroundHeightiPhonePortrait		407
#define faadLogoXiPhonePortrait				10
#define faadLogoYiPhonePortrait				20
#define faadLogoWidthiPhonePortrait			158
#define faadlogoHeightiPhonePortrait		70
#define closeButtonXiPhonePortrait			260
#define closeButtonYiPhonePortrait			30	
#define closeButtonWidthiPhonePortrait		47
#define closeButtonHeightiPhonePortrait		47
#define adsScrollViewXiPhonePortrait		0
#define adsScrollViewYiPhonePortrait		100
#define adsScrollViewWidthiPhonePortrait	320
#define adsScrollViewHeightiPhonePortrait	239
#define pageControllerXiPhonePortrait		108
#define pageControllerYiPhonePortrait		315
#define pageControllerWidthiPhonePortrait	102
#define pageControllerHeightiPhonePortrait	37
#define downloadButtonXiPhonePortrait		117
#define downloadButtonYiPhonePortrait		340
#define downloadButtonWidthiPhonePortrait	97
#define downloadButtonHeightiPhonePortrait	97

#define backgroundXiPad          0
#define backgroundYiPad          0
#define backgroundWidthiPad      600
#define backgroundHeightiPad     600
#define faadLogoXiPad            0
#define faadLogoYiPad            0
#define faadLogoWidthiPad        319
#define faadLogoHeightiPad       128
#define closeButtonXiPad         544
#define closeButtonYiPad         0
#define closeButtonWidthiPad     62
#define closeButtonHeightiPad    62
#define adsScrollViewXiPad       0  
#define adsScrollViewYiPad       160
#define adsScrollViewWidthiPad   600 
#define adsScrollViewHeightiPad  360
#define pageControllerXiPad      265
#define pageControllerYiPad      500
#define pageControllerWidthiPad  72
#define pageControllerHeightiPad 36
#define downloadButtonXiPad      258
#define downloadButtonYiPad      530
#define downloadButtonWidthiPad  97
#define downloadButtonHeightiPad 97

#define iconInitialXiPad  100
#define iconInitialYiPad  45
#define appIconWidthiPad  64
#define appIconHeightiPad 64
#define appNameXiPad      170 
#define appNameYiPad      35
#define appTitleWidthiPad  190
#define appTitleHeightiPad 50
#define appDescXiPad      170
#define appDescYiPad      40
#define appDescWidthiPad   350
#define appDescHeightiPad  240
#define deltaXiPad        1024

#define portraitViewXStatusBarHidden       0
#define portraitViewYStatusBarHidden       0
#define portraitViewWidthStatusBarHidden   320
#define portraitViewHeightStatusBarHidden  480
#define portraitViewXStatusBarVisible      0
#define portraitViewYStatusBarVisible      20
#define portraitViewWidthStatusBarVisible  320
#define portraitViewHeightStatusBarVisible 480

#define landscapeViewXStatusBarHidden          0
#define landscapeViewYStatusBarHidden          0
#define landscapeViewWidthStatusBarHidden      480
#define landscapeViewHeightStatusBarHidden     320
#define landscapeViewXStatusBarVisible         0
#define landscapeViewYStatusBarVisible         20
#define landscapeViewWidthStatusBarVisible     480
#define landscapeViewHeightStatusBarVisible    320

#define landscapeViewX       0
#define landscapeViewY       0
#define landscapeViewWidth   480
#define landscapeViewHeight  320
#define landscapeViewWithStatusBarCenterX    180
//addition
#define landscapeViewWithStatusBarCenterXPadding 40
//
#define landscapeViewWithStatusBarCenterY    240
#define landscapeViewWithoutStatusBarCenterX 160
#define landscapeViewWithoutStatusBarCenterY 240
#define landscapeViewLeftOrientedCenterX   -180
#define landscapeViewLeftOrientedCenterY    240
#define landscapeViewRightOrientedCenterX   360
#define landscapeViewRightOrientedCenterY   240

#define portraitViewX        0
#define portraitViewY        0
#define portrtaitViewWidth   320
#define portraitViewHeight   480
#define portraitViewWithStatusBarCenterX      160
#define portraitViewWithStatusBarCenterY      250 
#define portraitViewWithoutStatusBarCenterX   160
#define portraitViewWithoutStatusBarCenterY   230

#define iPadPortraitViewX       75
#define iPadPortraitViewY       66
#define iPadPortraitViewWidth   786
#define iPadPortraitViewHeight  1024
#define iPadPortraitViewCenterX 480
#define iPadPortraitViewCenterY 640

#define iPadLandscapeViewX       202
#define iPadLandscapeViewY       84
#define iPadLandscapeViewWidth   1024
#define iPadLandscapeViewHeight  786
#define iPadLandscapeViewCenterX 450
#define iPadLandscapeViewCenterY 300

//
#define iPhoneLeftBracketX 10
#define iPhoneLeftBracketY 10

#define iPhoneRightBracketX 280
#define iPhoneRightBracketY 10

//
#define iPhoneLeftBracketHeight 200
#define iPhoneLeftBracketWidth 26

#define iPhoneRightBracketHeight 200
#define iPhoneRightBracketWidth 26



//addition
#define iPhoneLeftBracketLandscapeX 40
#define iPhoneLeftBracketLandscapeY 10
//

#define iPhoneLeftBracketHeightLandscape 100
#define iPhoneLeftBracketWidthLandscape 16

//addition
#define iPhoneRightBracketLandscapeX 400 
#define iPhoneRightBracketLandscapeY 10 
//

#define iPhoneRightBracketHeightLandscape 100 
#define iPhoneRightBracketWidthLandscape 16


//addition
#define iPadLeftBracketX 40
#define iPadLeftBracketY 10
//

#define iPadLeftBracketHeight 300
#define iPadLeftBracketWidth 40

//addition
#define iPadRightBracketX 500
#define iPadRightBracketY 10
//

#define iPadRightBracketHeight 300
#define iPadRightBracketWidth 40

//addition
#define iPadLeftBracketXPortrait 40
#define iPadLeftBracketYPortrait 10
//
#define iPadLeftBracketHeightPortrait 300
#define iPadLeftBracketWidthPortrait 40


//addition
#define iPadRightBracketXPortrait 500
#define iPadRightBracketYPortrait 10

//
#define iPadRightBracketHeightPortrait 300
#define iPadRightBracketWidthPortrait 40


#define iPadViewX        0
#define iPadViewY        0
#define iPadViewWidth    1024
#define iPadViewHeight   768

//Salman
#define iPhoneFaadLandscapeViewWithStatusBarX 0.0
#define iPhoneFaadLandscapeViewWithStatusBarY 20.0

#define iPhoneFaadLandscapeViewWithOutStatusBarX 0.0
#define iPhoneFaadLandscapeViewWithOutStatusBarY 0.0

#define iPhoneLandscapeWidth 480
#define iPhoneLandscapeHeight 320



#define iPadFaadLandscapeViewX 94
#define iPadFaadLandscapeViewY 212
#define iPadFaadLandscapeViewWidth 600
#define iPadFaadLandscapeViewHeight 600


#define iPhoneFaadPortraitViewWithStatusBarX 0.0
#define iPhoneFaadPortraitViewWithStatusBarY 20.0
#define iPhoneFaadPortraitViewWithStatusBarWidth 320
#define iPhoneFaadPortraitViewWithStatusBarHeight 460

#define iPhoneFaadPortraitViewWithOutStatusBarX 0.0
#define iPhoneFaadPortraitViewWithOutStatusBarY 0.0
#define iPhoneFaadPortraitViewWithOutStatusBarWidth 320
#define iPhoneFaadPortraitViewWithOutStatusBarHeight 480

#define iPadFaadPortraitViewX 75
#define iPadFaadPortraitViewY 66
#define iPadFaadPortraitViewWidth 768
#define iPadFaadPortraitViewHeight 1024

#define iPhoneLandscapeViewBackButtonX  100
#define iPhoneLandscapeViewBackButtonY  180
#define iPhoneLandscapeViewBackButtonWidth 32
#define iPhoneLandscapeViewBackButtonHeight 32

#define iPhoneLandscapeViewForwardButtonX  320
#define iPhoneLandscapeViewForwardButtonY  180
#define iPhoneLandscapeViewForwardButtonWidth 32
#define iPhoneLandscapeViewForwardButtonHeight 32

#define iPhonePortraitViewBackButtonX  100
#define iPhonePortraitViewBackButtonY  300
#define iPhonePortraitViewBackButtonWidth 32
#define iPhonePortraitViewBackButtonHeight 32

#define iPhonePortraitViewForwardButtonX  179
#define iPhonePortraitViewForwardButtonY  300
#define iPhonePortraitViewForwardButtonWidth 32
#define iPhonePortraitViewForwardButtonHeight 32

#define iPadPortraitViewBackButtonX  200
#define iPadPortraitViewBackButtonY  500
#define iPadPortraitViewBackButtonWidth 32
#define iPadPortraitViewBackButtonHeight 32

#define iPadPortraitViewForwardButtonX  375
#define iPadPortraitViewForwardButtonY  500
#define iPadPortraitViewForwardButtonWidth 32
#define iPadPortraitViewForwardButtonHeight 32

#define iPadLandscapeViewBackButtonX  200
#define iPadLandscapeViewBackButtonY  500
#define iPadLandscapeViewBackButtonWidth 32
#define iPadLandscapeViewBackButtonHeight 32

#define iPadLandscapeViewForwardButtonX  375
#define iPadLandscapeViewForwardButtonY  500
#define iPadLandscapeViewForwardButtonWidth 32
#define iPadLandscapeViewForwardButtonHeight 32

#define imageViewtag    1000
#define appNameTag  1001
#define appDescTag  1002


//Image Name used in sdk
#define  iconImageplaceHolder @"place_holder.png"
#define leftBracketImageIpad @"v_braket_left_ipad.png"
#define rightBracketImageIpad @"v_braket_right_ipad.png"

#define leftBracketImagePortraitIphone @"v_left_braket.png"
#define rightBracketImagePortraitIphone @"v_right_braket.png"

#define leftHorizentalBracketIphone @"h_bracket_left.png"
#define rightHorizentalBracketIphone @"h_bracket_right.png"

#define leftHorizentalBracketPortraitIpad @"h_braket_left_ipad.png"
#define rightHorizentalBracketPortraitIpad @"h_braket_right_ipad.png"


#define backgroundAdsImageIphone @"op_Horizontal_iP4.png"
#define backgroundAdsImagePortraitIphone @"op_Vertical_iP4.png"
#define backgroundAdsImageIpad @"ipad_back.png"
#define logoImage @"logo.png"
#define logoImageIpad @"ipad_logo.png"
#define closeButtonImage @"close_x.png"
#define closeButtonImageIpad @"ipad_close.png"
#define downloadButtonImage @"download_button.png"
#define downloadButtonImageIpad @"ipad_download.png"

#define forwardButtonImagelow @"rightarrow32.png"
#define backButtonImagelow @"leftarrow32.png"
#define forwardButtonImagelowoff @"rightarrow32_off.png"
#define backButtonImagelowoff @"leftarrow32_off.png"

#define forwardButtonImageHigh @"rightarrow32@2x.png"
#define backButtonImageHigh @"leftarrow32@2x.png"
#define forwardButtonImageHighoff @"rightarrow32_off@2x.png"
#define backButtonImageHighoff @"leftarrow32_off@2x.png"

typedef enum { 
	iPhone = 0,
	iPad = 1
} deviceType;

typedef enum {
	landscapeLeft = UIInterfaceOrientationLandscapeLeft,
	landscapeRight = UIInterfaceOrientationLandscapeRight,
	portrait = UIInterfaceOrientationPortrait,
	portraitUpsideDown = UIInterfaceOrientationPortraitUpsideDown
	
} faadDeviceOrientation; 

/**
 * the default urls
 *
 */

//  Live server

#define kFAADNetworkServiceURL @"http://ws.faad.co/ws/faad/getFeed"
#define kFAADOfferClickedURL @"http://ws.faad.co/ws/faad/offerclicked"
#define kFAADConnectURL @"http://ws.faad.co/ws/faad/connect"
#define kFAADTrackingURL @"http://ws.faad.co/ws/faad/trackSessions"
#define kFAADKeyValueServiceURL @"http://ws.faad.co/ws/faad/getServerData"

//  Local server


//#define kFAADNetworkServiceURL @"http://98.143.153.131:8080/ws/faad/getFeed"
//#define kFAADOfferClickedURL @"http://98.143.153.131:8080/ws/faad/offerclicked"
//#define kFAADConnectURL @"http://98.143.153.131:8080/ws/faad/connect" 
//#define kFAADTrackingURL @"http://98.143.153.131:8080/ws/faad/trackSessions"



/**
 * standard imports
 */
#import "FAADUtility.h"
#import "FAADConnectWebService.h"
#import "JSON.h"
#import "FAADAdsController.h"
#import "FAADNetworkWebService.h"
#import "FAADOfferClickedWebService.h"
#import "FAADLandscapeView.h"
#import "FAADPortraitView.h"
#import "UIImageView+web.h"
#import "FAADNetwork.h"
#import "FAADHttpRequest.h"
#import "FAADTracking.h"
#import "FAADTrackingWebService.h"
#import "FAADDatabase.h"
#import "FAADSessionObject.h"
#include "OpenUDID.h"