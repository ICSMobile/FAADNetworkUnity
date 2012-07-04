//
//  FAADLandscapeView.m
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved

#import "FAADLandscapeView.h"
#import "FAADCommon.h"

@implementation FAADLandscapeView

@synthesize closeButton = closeButton_;
@synthesize downloadButton = button;
@synthesize adsScrollView = adsScrollView_;
@synthesize spinner = spinner_;
@synthesize pageControl = pageControl_;
@synthesize currentAds = currentAds_;
@synthesize offerClickedWebService = offerClickedWebService_;
@synthesize isStatusBar = isStatusBar_;
@synthesize containerView = containerView_;
static int numberOfPages = 0;
static int currentPage = 0;
static int lastOrientation = -1;

@synthesize forwardButton = forwardButton_, backButton = backButton_;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    self.tag = 1;
		self.frame = frame;
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
      if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
        [self setiPhoneLayout];
      }else
        [self setiPadLayout];
		
    }
    return self;
}

- (void)setiPhoneLayout{
  
  UIImageView *background = [[UIImageView alloc] init];
  background.frame = CGRectMake(backgroundXiPhoneLandscape, backgroundYiPhoneLandscape, backgroundWidthiPhoneLandscape, backgroundHeightiPhoneLandscape);
  UIImage *backroundImage = [UIImage imageNamed:backgroundAdsImageIphone];
  background.image = backroundImage;
  background.autoresizesSubviews = YES;
  [self addSubview:background];
  [background release];
  
  UIImageView *logo = [[UIImageView alloc] init];
  logo.frame = CGRectMake(faadLogoXiPhoneLandscape, faadLogoYiPhoneLandscape, faadLogoWidthiPhoneLandscape, faadlogoHeightiPhoneLandscape);
  logo.image = [UIImage imageNamed:logoImage];
 // [self addSubview:logo];
  [logo release];
  
  closeButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton_.frame = CGRectMake(closeButtonXiPhoneLandscape, closeButtonYiPhoneLandscape, closeButtonWidthiPhoneLandscape, closeButtonHeightiPhoneLandscape);
  UIImage *buttonImageClose = [UIImage imageNamed:closeButtonImage];
  closeButton_.backgroundColor = [UIColor clearColor];
  [closeButton_ setBackgroundImage:buttonImageClose forState:UIControlStateNormal];
  [closeButton_ addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:closeButton_];
  
  adsScrollView_ = [[UIScrollView alloc] init];
  adsScrollView_.frame = CGRectMake(adsScrollViewXiPhoneLandscape, adsScrollViewYiPhoneLandscape, adsScrollViewWidthiPhoneLandscape, adsScrollViewHeightiPhoneLandscape);
  adsScrollView_.pagingEnabled = NO;
  adsScrollView_.showsVerticalScrollIndicator = NO;
  adsScrollView_.showsHorizontalScrollIndicator = NO;
  adsScrollView_.delegate = self;
  [self addSubview:adsScrollView_];
    
    backButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton_.tag = 0;
    backButton_.frame = CGRectMake(iPhoneLandscapeViewBackButtonX, iPhoneLandscapeViewBackButtonY, iPhoneLandscapeViewBackButtonWidth, iPhoneLandscapeViewBackButtonHeight);
    UIImage *buttonImageBack = [UIImage imageNamed:backButtonImagelow];
    UIImage *buttonImageBackOff = [UIImage imageNamed:backButtonImagelowoff];
    [backButton_ setBackgroundImage:buttonImageBackOff forState:UIControlStateDisabled];
    [backButton_ setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backButton_ addTarget:self action:@selector(updateViewOnForwardBackbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton_];
    [backButton_ setHidden:YES];
    [backButton_ setEnabled:NO];
    
    forwardButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton_.tag = 1;
    forwardButton_.frame = CGRectMake(iPhoneLandscapeViewForwardButtonX, iPhoneLandscapeViewForwardButtonY, iPhoneLandscapeViewForwardButtonWidth, iPhoneLandscapeViewForwardButtonHeight);
    UIImage *buttonImageFwd = [UIImage imageNamed:forwardButtonImagelow];
    UIImage *buttonImageFwdOff = [UIImage imageNamed:forwardButtonImagelowoff];
    [forwardButton_ setBackgroundImage:buttonImageFwd forState:UIControlStateNormal];
    [forwardButton_ setBackgroundImage:buttonImageFwdOff forState:UIControlStateDisabled];
    [forwardButton_ addTarget:self action:@selector(updateViewOnForwardBackbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forwardButton_];
    [forwardButton_ setHidden:YES];  
  
    
    spinner_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  spinner_.center = adsScrollView_.center;
  [spinner_ startAnimating];
  [self addSubview:spinner_];
  
  pageControl_ = [[UIPageControl alloc] init];
	CGRect rect= CGRectMake(pageControllerXiPhoneLandscape, pageControllerYiPhoneLandscape, pageControllerWidthiPhoneLandscape, pageControllerHeightiPhoneLandscape);
	[pageControl_ setFrame:rect];
  pageControl_.currentPage = 0;
	UIView *pageControlContainerView = [[UIView alloc] initWithFrame:rect];
	[pageControlContainerView addSubview:pageControl_];
	[pageControlContainerView setBackgroundColor:[UIColor clearColor]];
	[pageControlContainerView setOpaque:NO];
	[pageControlContainerView setCenter:CGPointMake(pageControlContainerViewX, pageControllerYiPhoneLandscape+pageControllerHeightiPhoneLandscape/2)];
	[self addSubview:pageControlContainerView];
	[pageControl_ setCenter:CGPointMake(pageControlCenerX, pageControllerHeightiPhoneLandscape/2)];
	pageControl_.hidesForSinglePage = YES;
	[pageControlContainerView release];
  
  button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(downloadButtonXiPhoneLandscape, downloadButtonYiPhoneLandscape, downloadButtonWidthiPhoneLandscape, downloadButtonHeightiPhoneLandscape);
  UIImage *buttonImageDownload = [UIImage imageNamed:downloadButtonImage];
  [button setBackgroundImage:buttonImageDownload forState:UIControlStateNormal];
  [button addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:button];
  [button setHidden:YES];

}

- (void)setiPadLayout{
  
  
  UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundXiPad, backgroundYiPad, backgroundWidthiPad, backgroundHeightiPad)];
  UIImage *backroundImage = [UIImage imageNamed:backgroundAdsImageIpad];
  background.image = backroundImage;
  background.autoresizesSubviews = YES;
  [self addSubview:background];
  [background release];
  
  UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(faadLogoXiPad, faadLogoYiPad, faadLogoWidthiPad, faadLogoHeightiPad)];
  logo.image = [UIImage imageNamed:logoImageIpad];
 // [self addSubview:logo];
  [logo release];
  
  closeButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton_.frame = CGRectMake(closeButtonXiPad, closeButtonYiPad, closeButtonWidthiPad, closeButtonHeightiPad);
  UIImage *buttonImageClose = [UIImage imageNamed:closeButtonImageIpad];
  closeButton_.backgroundColor = [UIColor clearColor];
  [closeButton_ setBackgroundImage:buttonImageClose forState:UIControlStateNormal];
  [closeButton_ addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:closeButton_];
  
  adsScrollView_ = [[UIScrollView alloc] initWithFrame:CGRectMake(adsScrollViewXiPad, adsScrollViewYiPad, adsScrollViewWidthiPad, adsScrollViewHeightiPad)];
  adsScrollView_.pagingEnabled = NO;
  adsScrollView_.showsVerticalScrollIndicator = NO;
  adsScrollView_.showsHorizontalScrollIndicator = NO;
  adsScrollView_.delegate = self;
  [self addSubview:adsScrollView_];
    
    backButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton_.tag = 0;
    backButton_.frame = CGRectMake(iPadLandscapeViewBackButtonX, iPadLandscapeViewBackButtonY, iPadLandscapeViewBackButtonWidth, iPadLandscapeViewBackButtonHeight);
    UIImage *buttonImageBack = [UIImage imageNamed:backButtonImagelow];
    UIImage *buttonImageBackOff = [UIImage imageNamed:backButtonImagelowoff];
    [backButton_ setBackgroundImage:buttonImageBackOff forState:UIControlStateDisabled];
    [backButton_ setBackgroundImage:buttonImageBack forState:UIControlStateNormal];
    [backButton_ addTarget:self action:@selector(updateViewOnForwardBackbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton_];
    [backButton_ setHidden:YES];
    [backButton_ setEnabled:NO];
    
    forwardButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton_.tag = 1;
    forwardButton_.frame = CGRectMake(iPadLandscapeViewForwardButtonX, iPadLandscapeViewForwardButtonY, iPadLandscapeViewForwardButtonWidth, iPadLandscapeViewForwardButtonHeight);
    UIImage *buttonImageFwd = [UIImage imageNamed:forwardButtonImagelow];
    UIImage *buttonImageFwdOff = [UIImage imageNamed:forwardButtonImagelowoff];
    [forwardButton_ setBackgroundImage:buttonImageFwd forState:UIControlStateNormal];
    [forwardButton_ setBackgroundImage:buttonImageFwdOff forState:UIControlStateDisabled];
    [forwardButton_ addTarget:self action:@selector(updateViewOnForwardBackbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forwardButton_];
    [forwardButton_ setHidden:YES];  
    
    
  spinner_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  spinner_.center = adsScrollView_.center;
  [spinner_ startAnimating];
  [self addSubview:spinner_];
  
  pageControl_ = [[UIPageControl alloc] initWithFrame:CGRectMake(pageControllerXiPad, pageControllerYiPad, pageControllerWidthiPad, pageControllerHeightiPad)];
  pageControl_.currentPage = 0;
  [self addSubview:pageControl_];
  
  button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(downloadButtonXiPad, downloadButtonYiPad, downloadButtonWidthiPad, downloadButtonHeightiPad);
  UIImage *buttonImageDownload = [UIImage imageNamed:downloadButtonImageIpad];
  [button setBackgroundImage:buttonImageDownload forState:UIControlStateNormal];
  [button addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:button];
  [button setHidden:YES];


}

-(void)updateViewOnForwardBackbutton:(UIButton*)sender
{
     if(sender.tag == 0)//bckpressed
    {
        
        if(currentPage >= 1){
            [forwardButton_ setEnabled:YES];
            currentPage--;
            if(currentPage == 0){
                [backButton_ setEnabled:NO];
                currentPage = 0;
            }
        }
        
        
        
    }
    else if (sender.tag == 1){//fwd pressed
        
        if(currentPage <= [currentAds_ count] ){
            currentPage++;
            if(currentPage == [currentAds_ count] - 1){
                [forwardButton_ setEnabled:NO];
            }
        }
        
        
        if(currentPage >= 1){
            [backButton_ setEnabled:YES];
        }
        
        
    }
    
    UIImageView *iconImageView = nil;
    UITextView  *appName = nil;
	UITextView  *appDesc = nil;
    
    iconImageView = (UIImageView*)[adsScrollView_ viewWithTag:imageViewtag];
    appName = (UITextView*)[adsScrollView_ viewWithTag:appNameTag];
    appDesc = (UITextView*)[adsScrollView_ viewWithTag:appDescTag];
    
    [appDesc setText:nil];
    [appName setText:nil];
    [iconImageView setImage:nil];
    
    NSDictionary *object = [currentAds_ objectAtIndex:currentPage];//i];
    NSString *url = [object objectForKey:kFAADApplicationImageURL];
    url = [url stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
    [iconImageView setImageWithUrl:url placeHolder:[UIImage imageNamed:iconImageplaceHolder]];
    
    [appName setText:[object objectForKey:kFAADCampaignName]];
    [appName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [appName setTextColor:[UIColor whiteColor]];
    [appName setBackgroundColor:[UIColor clearColor]];
    
    [appDesc setText:[object objectForKey:kFAADCampaignDescription]];
    [appDesc setTextColor:[UIColor whiteColor]];
    [appDesc setBackgroundColor:[UIColor clearColor]];
    
    object = nil;
}


- (void)displayLayoutWithStatusBar:(BOOL)statusBar{
  isStatusBar_ = statusBar;
  lastOrientation = [UIDevice currentDevice].orientation;
  //Save the default orientation for the device.
  //move the device according to the device type.UIInterfaceOrientationLandscapeRight
//  
  
   UIApplication *application = [UIApplication sharedApplication];
  UIWindow *rootWindow = [application keyWindow];
  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
  //check for iphone face
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    [rootWindow addSubview:self];
    if(orientation == landscapeLeft){
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(-90)); 
    }else if(orientation == landscapeRight){
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(90)); 
    }else{
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
    }
    [self setFrame:CGRectMake(landscapeViewX, landscapeViewY, landscapeViewWidth, landscapeViewHeight)];
    [self setBounds:CGRectMake(landscapeViewX, landscapeViewY, landscapeViewWidth, landscapeViewHeight)];
    if(orientation == landscapeLeft){
      self.center = CGPointMake(landscapeViewLeftOrientedCenterX, landscapeViewLeftOrientedCenterY);
    }else if(orientation == landscapeRight){
      self.center = CGPointMake(landscapeViewRightOrientedCenterX, landscapeViewRightOrientedCenterY);
      
    }else{
      self.center = CGPointMake(landscapeViewLeftOrientedCenterX, landscapeViewLeftOrientedCenterY);
    }

  }else {
	
	  
    containerView_ = [[UIView alloc] initWithFrame:CGRectMake(iPadViewX, iPadViewY,iPadViewHeight,iPadViewWidth)];
   
	  
	 // [rootWindow addSubview:self];
	  


    if(orientation == landscapeLeft){
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(-90)); 
    }else if(orientation == landscapeRight){
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(90)); 
    }else{
      self.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
    }
  }

  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.75f];

     if(isStatusBar_){
       if(orientation == landscapeLeft){
         [self setCenter:CGPointMake(landscapeViewWithStatusBarCenterX, landscapeViewWithStatusBarCenterY)];
       }else if(orientation == landscapeRight){
        [self setCenter:CGPointMake(landscapeViewWithStatusBarCenterX - landscapeViewWithStatusBarCenterXPadding, landscapeViewWithStatusBarCenterY)];
         
       }else{
       [self setCenter:CGPointMake(landscapeViewWithStatusBarCenterX, landscapeViewWithStatusBarCenterY)];
       }
       
   
 //       self.center = CGPointMake(240,160);
     }else{
       [self setCenter:CGPointMake(landscapeViewWithoutStatusBarCenterX, landscapeViewWithoutStatusBarCenterY)];
     }
           [UIView commitAnimations];
  }else{
    
    //[self setBounds:CGRectMake(iPadViewX, iPadViewY, iPadViewWidth, iPadViewHeight)];
    //[self setFrame:CGRectMake(iPadLandscapeViewX, iPadLandscapeViewY, iPadLandscapeViewWidth, iPadLandscapeViewHeight)];
	 
	  //UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	  
	  
	  //if (orientation==landscapeRight) { 
//		[self setCenter:CGPointMake(310,726)];//iPadLandscapeViewCenterX,iPadLandscapeViewCenterY  
//	  }else
	 // [self setFrame:CGRectMake(94, 212, 600, 600)];
	//	  [self setCenter:CGPointMake(iPadLandscapeViewCenterX,iPadLandscapeViewCenterY)];
	  
	  [containerView_ addSubview:self];
	  [rootWindow addSubview:containerView_];
  }
	


}

- (void)closeView {
  for(UIView *subview in [adsScrollView_ subviews]) {
    
    [subview removeFromSuperview];
  }
    
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(remove)];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == landscapeLeft){
      self.center = CGPointMake(landscapeViewLeftOrientedCenterX, landscapeViewLeftOrientedCenterY);
    }else if(orientation == landscapeRight){
      self.center = CGPointMake(landscapeViewRightOrientedCenterX, landscapeViewRightOrientedCenterY);
    }else{
      self.center = CGPointMake(landscapeViewLeftOrientedCenterX, landscapeViewLeftOrientedCenterY);
    }
    [UIView commitAnimations];
  } else {
    [containerView_ removeFromSuperview];
    [self remove];
  }
  
 // UIWindow *rootWindow = [[UIApplication sharedApplication] keyWindow];
 // UIView *currentView =  [rootWindow viewWithTag:1];
  //[currentView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:kFAADFeedViewClosed object:nil];
}

- (void)remove{
  UIWindow *rootWindow = [[UIApplication sharedApplication] keyWindow];
  UIView *currentView =  [rootWindow viewWithTag:1];
  [currentView removeFromSuperview];
  
}
- (void)download {
  NSDictionary *object = [self.currentAds objectAtIndex:currentPage];
  int offerID = [[object objectForKey:kFAADCampaignId] intValue];
  [self closeView];
  [self downloadOfferForId:offerID];
    currentPage = 0;
}

- (void)downloadOfferForId:(int)offerId{
  
  if(offerClickedWebService_ == nil){
    offerClickedWebService_ = [[FAADOfferClickedWebService alloc]init];
  }
  [offerClickedWebService_ sendRequestWithOfferNumber:offerId];
  
}
- (void)displayAds:(NSArray*)currentAds {
  self.currentAds = currentAds;
	numberOfPages = [currentAds count];
	pageControl_.numberOfPages = numberOfPages;
  adsScrollView_.contentSize = CGSizeMake(adsScrollView_.frame.size.width * 1/*numberOfPages*/, adsScrollView_.frame.size.height);
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPad){
    [self loadAdsIniPad];
  }else
  {
    [self loadAdsIniPhone];
  
  }
    
    [backButton_ setHidden:NO];
    [forwardButton_ setHidden:NO];
	[button setHidden:NO];
    [spinner_ setHidesWhenStopped:YES];
	[spinner_ stopAnimating];
}

- (void)loadAdsIniPhone{
  int initialX = 0;
  
//  if(numberOfPages == 1){
//    pageControl_.hidden = YES;
//  }else
//    pageControl_.hidden = NO;
    
    pageControl_.hidden = YES;
  
  
  UIImageView *iconImageView = nil;
	UITextView  *appName = nil;
	UITextView  *appDesc = nil;
  UIImageView *leftBracket = nil;
  UIImageView *rightBracket = nil;
    
    //int randomAdNumber = arc4random_uniform([currentAds_ count]);
	//for(int i =0 ; i < [currentAds_ count]; i++){
    
    NSDictionary *object = [currentAds_ objectAtIndex:0];
    NSString *url = [object objectForKey:kFAADApplicationImageURL];
    url = [url stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
    
    iconImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconImageplaceHolder]];
    iconImageView.tag = imageViewtag;
    [iconImageView setFrame:CGRectMake(iconInitialX + initialX, iconInitialY, appIconWidth, appIconHeight)];
    [iconImageView setImageWithUrl:url placeHolder:[UIImage imageNamed:iconImageplaceHolder]];
    [adsScrollView_ addSubview:iconImageView];
    [iconImageView release];
    
    
    UIButton *buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame = CGRectMake(iconInitialX + initialX, iconInitialY, appIconWidth, appIconHeight);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
    
    leftBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftHorizentalBracketIphone]];
    [leftBracket setFrame:CGRectMake(iPhoneLeftBracketLandscapeX + initialX, iPhoneLeftBracketLandscapeY, iPhoneLeftBracketWidthLandscape, iPhoneLeftBracketHeightLandscape)];
    [adsScrollView_ addSubview:leftBracket];
    leftBracket = nil;
    buttonz = nil;
    
		CGSize appBoundingSize = CGSizeMake(appTitleWidth, CGFLOAT_MAX);
		CGSize aapRequiredSize = [[object objectForKey:kFAADCampaignName] sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]
                                                                 constrainedToSize:appBoundingSize
                                                                     lineBreakMode:UILineBreakModeWordWrap];
		CGFloat titleHeight = aapRequiredSize.height;	
    appName = [[UITextView alloc] init];
    appName.tag = appNameTag;
    [appName setFrame:CGRectMake(appNameX + initialX, appNameY, appTitleWidth, titleHeight + heightOffset)];
    [appName setUserInteractionEnabled:NO];
    [appName setText:[object objectForKey:kFAADCampaignName]];
    [appName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [appName setTextColor:[UIColor whiteColor]];
    [appName setBackgroundColor:[UIColor clearColor]];
    [adsScrollView_ addSubview:appName];
    [appName release];
		
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame = CGRectMake(appNameX + initialX, appNameY, appTitleWidth, titleHeight + heightOffset);
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
		CGSize desBoundingSize = CGSizeMake(appTitleWidth, CGFLOAT_MAX);
		CGSize desRequiredSize = [[object objectForKey:kFAADCampaignDescription] sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]
                                                                 constrainedToSize:desBoundingSize
                                                                     lineBreakMode:UILineBreakModeWordWrap];
		CGFloat desHeight = desRequiredSize.height;
        if(desHeight > 100.0){
            desHeight = 60.0;
        }
    
    appDesc= [[UITextView alloc] init];
    appDesc.tag = appDescTag;
    [appDesc setFrame:CGRectMake(appDescX + initialX, appNameY + titleHeight, appDescWidth, desHeight+heightOffset)];
    [appDesc setUserInteractionEnabled:NO];
    [appDesc setText:[object objectForKey:kFAADCampaignDescription]];
		[appDesc setTextColor:[UIColor whiteColor]];
    [appDesc setBackgroundColor:[UIColor clearColor]];
    [adsScrollView_ addSubview:appDesc];
    [appDesc release];
    
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame = CGRectMake(appDescX + initialX, appNameY + titleHeight, appDescWidth, desHeight+heightOffset);
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
    rightBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightHorizentalBracketIphone]];
    [rightBracket setFrame:CGRectMake(iPhoneRightBracketLandscapeX + initialX, iPhoneRightBracketLandscapeY, iPhoneRightBracketWidthLandscape, iPhoneRightBracketHeightLandscape)];
    [adsScrollView_ addSubview:rightBracket];
    rightBracket = nil;
    
    
    initialX += 480;
    object = nil;
	//}
  
}
- (void)loadAdsIniPad{
  int initialX = 0;
  
    pageControl_.hidden = YES;
  UIImageView *iconImageView = nil;
	UITextView  *appName = nil;
	UITextView  *appDesc = nil;
  UIImageView *leftBracket = nil;
  UIImageView *rightBracket = nil;
    
    
    NSDictionary *object = [currentAds_ objectAtIndex:0];
    NSString *url = [object objectForKey:kFAADApplicationImageURL];
    url = [url stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
    iconImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconImageplaceHolder]];
    iconImageView.tag = imageViewtag;
    [iconImageView setFrame:CGRectMake(iconInitialXiPad + initialX, iconInitialYiPad, appIconWidthiPad, appIconHeightiPad)];
    [iconImageView setImageWithUrl:url placeHolder:[UIImage imageNamed:iconImageplaceHolder]];
    [adsScrollView_ addSubview:iconImageView];
    [iconImageView release];
		
    UIButton   *buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame = CGRectMake(iconInitialXiPad + initialX, iconInitialYiPad, appIconWidthiPad, appIconHeightiPad);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
    leftBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftBracketImageIpad]];
    [leftBracket setFrame:CGRectMake(iPadLeftBracketX + initialX, iPadLeftBracketY, iPadLeftBracketWidth, iPadLeftBracketHeight)];
    [adsScrollView_ addSubview:leftBracket];
    leftBracket = nil;
    buttonz = nil;

    
	  CGSize appBoundingSize = CGSizeMake(appTitleWidth, CGFLOAT_MAX);
	  CGSize aapRequiredSize = [[object objectForKey:kFAADCampaignName] sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]
                                                                 constrainedToSize:appBoundingSize
                                                                     lineBreakMode:UILineBreakModeWordWrap];
	  CGFloat titleHeight = aapRequiredSize.height;
		
    appName = [[UITextView alloc] init];
    appName.tag = appNameTag;
    [appName setFrame:CGRectMake(appNameXiPad + initialX, appNameYiPad, appTitleWidthiPad, titleHeight+heightOffset)];
    [appName setUserInteractionEnabled:NO];
    [appName setText:[object objectForKey:kFAADCampaignName]];
    [appName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [appName setTextColor:[UIColor whiteColor]];
    [appName setBackgroundColor:[UIColor clearColor]];
    [adsScrollView_ addSubview:appName];
    [appName release];
		
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(appNameXiPad + initialX, appNameYiPad, appTitleWidthiPad, titleHeight+heightOffset);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
	  CGSize desBoundingSize = CGSizeMake(appTitleWidth, CGFLOAT_MAX);
	  CGSize desRequiredSize = [[object objectForKey:kFAADCampaignDescription] sizeWithFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]
                                                                 constrainedToSize:desBoundingSize
                                                                     lineBreakMode:UILineBreakModeWordWrap];
	  CGFloat desHeight = desRequiredSize.height;
    
    appDesc= [[UITextView alloc] init];
    appDesc.tag = appDescTag;
    [appDesc setFrame:CGRectMake(appDescXiPad + initialX, appNameYiPad + titleHeight, appDescWidthiPad, desHeight+heightOffset)];
    [appDesc setUserInteractionEnabled:NO];
    [appDesc setText:[object objectForKey:kFAADCampaignDescription]];
    [appDesc setTextColor:[UIColor whiteColor]];
    [appDesc setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
    [appDesc setBackgroundColor:[UIColor clearColor]];
    [adsScrollView_ addSubview:appDesc];
    [appDesc release];
    
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(appDescXiPad + initialX, appNameYiPad + titleHeight, appDescWidthiPad, desHeight+heightOffset);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    rightBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightBracketImageIpad]];
    [rightBracket setFrame:CGRectMake(iPadRightBracketX + initialX, iPadRightBracketY, iPadRightBracketWidth, iPadRightBracketHeight)];
    [adsScrollView_ addSubview:rightBracket];
    rightBracket = nil;

    
    initialX += 600;
    object = nil;
	  
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
		
	CGFloat pageWidth = adsScrollView_.frame.size.width;
	int page = floor((adsScrollView_.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if(page == 0 ){
		pageControl_.currentPage = currentPage-1;
	}else {
		pageControl_.currentPage = page;
	}
    currentPage = page;
    
	
}

- (void)dealloc {
 [button release];
	[closeButton_ release];
	[adsScrollView_ release];
	[spinner_ release];
	[pageControl_ release];
  [currentAds_ release];
  [offerClickedWebService_ release];
  [containerView_ release];
    [forwardButton_ release];
    [backButton_ release];
  [super dealloc];
}


@end
