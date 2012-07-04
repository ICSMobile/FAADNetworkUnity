//
//  FAADAdsController.m
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved//

#import "FAADAdsController.h"
#import "FAADCommon.h"


@implementation FAADAdsController
@synthesize landscapeView = landscapeView_;
@synthesize portraitView = portraitView_;
@synthesize currentAds = currentAds_;
@synthesize networkWebService = networkWebService_;
@synthesize isStatusBar = isStatusBar_;
static int deviceorientation = 0;
static int currentOrientation = -1;

- (void)dealloc
{
 
  [landscapeView_ release];
  [portraitView_ release];
  [currentAds_ release];
  [networkWebService_ release];
  [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)displayLandScapeAdsWithStatusBar:(BOOL)statusBar{
  isStatusBar_ = statusBar;
    UIApplication *application = [UIApplication sharedApplication];
    deviceorientation = application.statusBarOrientation;
    currentOrientation = 1;
    [self displayLandscapeLayout];
    [self registerForFAADNotifications];
    [self getNetworkFeeds];
}



- (void)displayLandscapeLayout{
  landscapeView_ = nil;
  //check for device and then display the ads
  
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    if(isStatusBar_){
      landscapeView_ = [[FAADLandscapeView alloc] initWithFrame:CGRectMake(iPhoneFaadLandscapeViewWithStatusBarX,iPhoneFaadLandscapeViewWithStatusBarY, iPhoneLandscapeWidth, iPhoneLandscapeHeight)];
    }else{
      landscapeView_ = [[FAADLandscapeView alloc] initWithFrame:CGRectMake(iPhoneFaadLandscapeViewWithOutStatusBarX, iPhoneFaadLandscapeViewWithOutStatusBarX, iPhoneLandscapeWidth, iPhoneLandscapeHeight)];
    }
    
  }else
  {
    landscapeView_ = [[FAADLandscapeView alloc] initWithFrame:CGRectMake(iPadFaadLandscapeViewX,iPadFaadLandscapeViewY,iPadFaadLandscapeViewWidth,iPadFaadLandscapeViewHeight)];// ////202,84,1024,768
  
  }
    [landscapeView_ displayLayoutWithStatusBar:isStatusBar_];
}

- (void)displayPortraitAdsWithStatusBar:(BOOL)statusBar{
  isStatusBar_ = statusBar;
    UIApplication *application = [UIApplication sharedApplication];
    deviceorientation = application.statusBarOrientation;
    currentOrientation = 2;
   
    [self displayPortraitLayout];
    [self registerForFAADNotifications];
    [self getNetworkFeeds];
}

- (void)getNetworkFeeds{
  if(networkWebService_ == nil){
    networkWebService_ = [[FAADNetworkWebService alloc] init];
  }
	if([[FAADConnectWebService sharedFAADConnectWebService] sessionToken] != nil){
  [networkWebService_ sendRequestWithToken:[[FAADConnectWebService sharedFAADConnectWebService] sessionToken]];
	}else{
	//	NSLog(@"You are not connected with FAAD");
        [self processErrorCode504];

	}
}

- (void)displayPortraitLayout{
  portraitView_ = nil;
  
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    if(isStatusBar_){
    
    portraitView_ = [[FAADPortraitView alloc] initWithFrame:CGRectMake(iPhoneFaadPortraitViewWithStatusBarX, iPhoneFaadPortraitViewWithStatusBarY, iPhoneFaadPortraitViewWithStatusBarWidth, iPhoneFaadPortraitViewWithStatusBarHeight)];
    }else{
    portraitView_ = [[FAADPortraitView alloc] initWithFrame:CGRectMake(iPhoneFaadPortraitViewWithOutStatusBarX, iPhoneFaadPortraitViewWithOutStatusBarY, iPhoneFaadPortraitViewWithOutStatusBarWidth, iPhoneFaadPortraitViewWithOutStatusBarHeight)];
    }
    }else
  {
    portraitView_ = [[FAADPortraitView alloc] initWithFrame:CGRectMake(iPadFaadPortraitViewX,iPadFaadPortraitViewY,iPadFaadPortraitViewWidth,iPadFaadPortraitViewHeight)];
  
  }
  
  [portraitView_ displayLayoutWithStatusBar:isStatusBar_];
 

}



//Redhat

- (void)registerForFAADNotifications{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(faadAdsReceived:) name:kFAADAdsReceivedNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(faadAdsFailed:) name:kFAADAdsFailureNotification object:nil];
}


- (void)unRegisterForFAADNotifications{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADAdsReceivedNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADAdsFailureNotification object:nil];
}

#pragma NSNotification Methods
- (void)faadAdsFailed:(NSNotification*)notifyObj{
	//NSLog(@"Fail to received FAAD Ads");
    [self processNoAds];
    [self unRegisterForFAADNotifications];
}

- (void)faadAdsReceived:(NSNotification*)notifyObj{
  [self unRegisterForFAADNotifications];
  NSData *responseData = (NSData*)[notifyObj object];
	NSString *str = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    if([str rangeOfString:kFAADTokenErrorString].location == NSNotFound){
        NSArray *adsArray = [str JSONValue];
        currentAds_ = adsArray;
        if([currentAds_ count] > 0){
            [self displayAds];
        }else{
            [self processNoAds];
            return;
        }
    }else{
        NSDictionary *dict = [str JSONValue];
        if(dict != nil){
            NSString *responseStatus = [dict objectForKey:@"error"];
            int errorCode = [FAADUtility getErrorCode:responseStatus];
        if(errorCode == 504){
            [self processErrorCode504];
        }else if(errorCode == 402){
            [self processErrorCode402];
        }
    }else{
        [self processNoAds];
        return;
      }
    }
   
   [str release];

}

- (void)processErrorCode504{
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(faadReconnectedForAds:) name:kFAADReconnectedForAdsNotification object:nil];
  [[FAADConnectWebService sharedFAADConnectWebService] connectWithCallBack:kFAADReconnectedForAdsNotification];

}

- (void)faadReconnectedForAds:(NSNotification*)notifyObject{
    
  //check if we have erro in the connection then close the view.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADReconnectedForAdsNotification object:nil];

    NSDictionary  *responseDicitionary = [notifyObject object];
    if(responseDicitionary != nil){
    NSString *errorCode = [responseDicitionary objectForKey:@"error"];
        if(errorCode != nil){
        if([errorCode intValue] == 904){
        [self processNoAds];
        }
        }else{
            NSString * responseStatus = [responseDicitionary objectForKey:kFAADToken];
            if(responseStatus != nil){
                [self registerForFAADNotifications];
                [self getNetworkFeeds];
            }
        
        }
    }
}

- (void)processErrorCode402{
}

- (void)processNoAds{
  if(currentOrientation == 1){
    [landscapeView_ closeView];
  }else if(currentOrientation == 2){
  [portraitView_ closeView];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:kFAADFeedViewClosed object:nil];
}

- (void)displayAds{
    if(currentOrientation == 1){
      [landscapeView_ displayAds:currentAds_];
    }else if(currentOrientation == 2){
      [portraitView_ displayAds:currentAds_];
    }

}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
