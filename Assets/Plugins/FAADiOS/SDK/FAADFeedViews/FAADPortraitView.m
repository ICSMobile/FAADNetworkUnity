//
//  FAADPortraitView.m
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
#import "FAADPortraitView.h"
#import "FAADCommon.h"

@implementation FAADPortraitView

@synthesize closeButton = closeButton_;
@synthesize downloadButton = downloadButton_;
@synthesize adsScrollView = adsScrollView_;
@synthesize spinner = spinner_;
@synthesize pageControl = pageControl_;
@synthesize currentAds = currentAds_;
@synthesize offerClickedWebService = offerClickedWebService_;
@synthesize isStatusBar = isStatusBar_;
@synthesize containerView = containerView_;
@synthesize forwardButton = forwardButton_, backButton = backButton_;
static int numberOfPages = 0;
static int currentPage = 0;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.frame = frame;
    self.tag = 2;
      self.opaque = NO;
      self.backgroundColor = [UIColor clearColor];
      if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
        [self setiPhoneLayout];
      }else
        [self setiPadLayout];
      
    }
    return self;
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
    backButton_.frame = CGRectMake(iPadPortraitViewBackButtonX, iPadPortraitViewBackButtonY, iPadPortraitViewBackButtonWidth, iPadPortraitViewForwardButtonHeight);
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
    forwardButton_.frame = CGRectMake(iPadPortraitViewForwardButtonX, iPadPortraitViewForwardButtonY, iPadPortraitViewForwardButtonWidth, iPadPortraitViewForwardButtonHeight);
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
  pageControl_.hidesForSinglePage = YES;
  [self addSubview:pageControl_];

  
  downloadButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
  downloadButton_.frame = CGRectMake(downloadButtonXiPad, downloadButtonYiPad, downloadButtonWidthiPad, downloadButtonHeightiPad);
  UIImage *buttonImageDownload = [UIImage imageNamed:downloadButtonImageIpad];
  [downloadButton_ setBackgroundImage:buttonImageDownload forState:UIControlStateNormal];
  [downloadButton_ addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:downloadButton_];
  [downloadButton_ setHidden:YES];
  
  
}
- (void)setiPhoneLayout{
	
  // Background of the view according to landscape dimensions
  UIImageView *background = [[UIImageView alloc] init];
  background.frame = CGRectMake(backgroundXiPhonePortrait, backgroundYiPhonePortrait, backgroundWidthiPhonePortrait, backgroundHeightiPhonePortrait);
  
  UIImage *backroundImage = [UIImage imageNamed:backgroundAdsImagePortraitIphone];
  background.image = backroundImage;
  background.opaque = NO;
  background.autoresizesSubviews = YES;
  [self addSubview:background];
  [background release];
  
  //FAAD logo
  UIImageView *logo = [[UIImageView alloc] init] ;
  logo.frame = CGRectMake(faadLogoXiPhonePortrait, faadLogoYiPhonePortrait, faadLogoWidthiPhonePortrait, faadlogoHeightiPhonePortrait);
  logo.image = [UIImage imageNamed:logoImage];
 // [self addSubview:logo];
  [logo release];
  
  //Close(X) button settled down here.
  closeButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton_.frame = CGRectMake(closeButtonXiPhonePortrait, closeButtonYiPhonePortrait, closeButtonWidthiPhonePortrait, closeButtonHeightiPhonePortrait);
  UIImage *buttonImageClose = [UIImage imageNamed:closeButtonImage];
  [closeButton_ setBackgroundImage:buttonImageClose forState:UIControlStateNormal];
  [closeButton_ addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:closeButton_];
  
  //Scroll view added here.
  adsScrollView_ = [[UIScrollView alloc] init];
  adsScrollView_.frame = CGRectMake(adsScrollViewXiPhonePortrait, adsScrollViewYiPhonePortrait, adsScrollViewWidthiPhonePortrait, adsScrollViewHeightiPhonePortrait);
  adsScrollView_.pagingEnabled = NO;
  adsScrollView_.showsVerticalScrollIndicator = NO;
  adsScrollView_.showsHorizontalScrollIndicator = NO;
  adsScrollView_.scrollsToTop = NO;
  adsScrollView_.delegate = self;
//  adsScrollView_.backgroundColor = [UIColor redColor];
  [self addSubview:adsScrollView_];
    
    backButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton_.tag = 0;
    backButton_.frame = CGRectMake(iPhonePortraitViewBackButtonX, iPhonePortraitViewBackButtonY, iPhonePortraitViewBackButtonWidth, iPhonePortraitViewBackButtonHeight);
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
    forwardButton_.frame = CGRectMake(iPhonePortraitViewForwardButtonX, iPhonePortraitViewForwardButtonY, iPhonePortraitViewForwardButtonWidth, iPhonePortraitViewForwardButtonHeight);
    UIImage *buttonImageFwd = [UIImage imageNamed:forwardButtonImagelow];
    UIImage *buttonImageFwdOff = [UIImage imageNamed:forwardButtonImagelowoff];
    [forwardButton_ setBackgroundImage:buttonImageFwd forState:UIControlStateNormal];
    [forwardButton_ setBackgroundImage:buttonImageFwdOff forState:UIControlStateDisabled];
    [forwardButton_ addTarget:self action:@selector(updateViewOnForwardBackbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forwardButton_];
    [forwardButton_ setHidden:YES];
  
  pageControl_ = [[UIPageControl alloc] init];
  pageControl_.frame = CGRectMake(pageControllerXiPhonePortrait, pageControllerYiPhonePortrait, pageControllerWidthiPhonePortrait, pageControllerHeightiPhonePortrait);
  pageControl_.currentPage = 0;
  [self addSubview:pageControl_];
  
  // loading sign is added. You can start or stop its animation accordingly
  spinner_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  spinner_.center = adsScrollView_.center;
  [spinner_ startAnimating];
  [self addSubview:spinner_];
  
  // Here is the download/install button.
  downloadButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
  downloadButton_.frame = CGRectMake(downloadButtonXiPhonePortrait, downloadButtonYiPhonePortrait, downloadButtonWidthiPhonePortrait, downloadButtonHeightiPhonePortrait);
  UIImage *buttonImageInstall = [UIImage imageNamed:downloadButtonImage];
  [downloadButton_ setBackgroundImage:buttonImageInstall forState:UIControlStateNormal];
  [downloadButton_ addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:downloadButton_];
  [downloadButton_ setHidden:YES];

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
    [self setCenter:CGPointMake(160, -230)];
    [UIView commitAnimations];
  }else {
    [containerView_ removeFromSuperview];
    [self remove];
  }
    [[NSNotificationCenter defaultCenter] postNotificationName:kFAADFeedViewClosed object:nil];
}

- (void)remove{
 UIWindow *rootWindow = [[UIApplication sharedApplication] keyWindow];
  UIView *currentView =  [rootWindow viewWithTag:2];
  [currentView removeFromSuperview];

}

- (void)download {
  [self closeView];
  NSDictionary *object = [self.currentAds objectAtIndex:currentPage];
  int offerID = [[object objectForKey:kFAADCampaignId] intValue];
  [self downloadOfferForId:offerID];
    currentPage = 0;
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
	[downloadButton_ setHidden:NO];
	[spinner_ setHidesWhenStopped:YES];
	[spinner_ stopAnimating];
}

- (void)loadAdsIniPhone{
	int initialX = 0;
  
    pageControl_.hidden = YES;
    
	UIImageView *iconImageView = nil;
	UIImageView *leftBracket = nil;
  UIImageView *rightBracket = nil;
  UITextView  *appName = nil;
	UITextView  *appDesc = nil;
    		
    NSDictionary *object = [currentAds_ objectAtIndex:0];
		NSString *url = [object objectForKey:kFAADApplicationImageURL];
		url = [url stringByReplacingOccurrencesOfString:@"&#47;" withString:@"/"];
		iconImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconImageplaceHolder]];
    iconImageView.tag = imageViewtag;
		[iconImageView setFrame:CGRectMake(iconInitialXPortrait+ initialX, iconInitialYPortrait, appIconWidth, appIconHeight)];
		[iconImageView setImageWithUrl:url placeHolder:[UIImage imageNamed:iconImageplaceHolder]];
		[adsScrollView_ addSubview:iconImageView];
		[iconImageView release];
    
    
    
    UIButton *buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(iconInitialXPortrait+ initialX, iconInitialYPortrait, appIconWidth, appIconHeight);
    
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    
    
    leftBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftBracketImagePortraitIphone]];
    [leftBracket setFrame:CGRectMake(iPhoneLeftBracketX + initialX, iPhoneLeftBracketY, iPhoneLeftBracketWidth, iPhoneLeftBracketHeight)];
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
		[appName setFrame:CGRectMake(appNameXPortrait + initialX, appNameYPortrait, appTitleWidth, titleHeight+heightOffset)];
		[appName setUserInteractionEnabled:NO];
		[appName setText:[object objectForKey:kFAADCampaignName]];
		[appName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[appName setTextColor:[UIColor whiteColor]];
		[appName setBackgroundColor:[UIColor clearColor]];
		[adsScrollView_ addSubview:appName];
		[appName release];
    
    
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(appNameXPortrait + initialX, appNameYPortrait, appTitleWidth, titleHeight+heightOffset);
    
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
		[appDesc setFrame:CGRectMake(appDescXPortrait + initialX, appNameYPortrait+titleHeight, appDescWidthPortrait , desHeight+heightOffset)];
		[appDesc setUserInteractionEnabled:NO];
		[appDesc setText:[object objectForKey:kFAADCampaignDescription]];
		[appDesc setTextColor:[UIColor whiteColor]];
		[appDesc setBackgroundColor:[UIColor clearColor]];
		[adsScrollView_ addSubview:appDesc];
		[appDesc release];
    
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(appDescXPortrait + initialX, appNameYPortrait+titleHeight, appDescWidthPortrait , desHeight+heightOffset);
    
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
		
    rightBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightBracketImagePortraitIphone]];
    [rightBracket setFrame:CGRectMake(iPhoneRightBracketX + initialX, iPhoneRightBracketY, iPhoneLeftBracketWidth, iPhoneLeftBracketHeight)];
    [adsScrollView_ addSubview:rightBracket];
    rightBracket = nil;
    buttonz = nil;
    
		initialX += 320;
		object = nil;
	//}
    currentPage = 0;
	
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
		
		
    UIButton *buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(iconInitialXiPad + initialX, iconInitialYiPad, appIconWidthiPad, appIconHeightiPad);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
		
    leftBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftHorizentalBracketPortraitIpad]];
    [leftBracket setFrame:CGRectMake(iPadLeftBracketXPortrait + initialX, iPadLeftBracketYPortrait , iPadLeftBracketWidthPortrait, iPadLeftBracketHeightPortrait)];
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
    [appDesc setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[appDesc setTextColor:[UIColor whiteColor]];
		[appDesc setBackgroundColor:[UIColor clearColor]];
		[adsScrollView_ addSubview:appDesc];
		[appDesc release];
    
    buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonz.frame =CGRectMake(appDescXiPad + initialX, appNameYiPad + titleHeight, appDescWidthiPad, desHeight+heightOffset);
    [buttonz addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [adsScrollView_ addSubview:buttonz];
    buttonz = nil;
    
    rightBracket = [[UIImageView alloc] initWithImage:[UIImage imageNamed:rightHorizentalBracketPortraitIpad]];
    [rightBracket setFrame:CGRectMake(iPadRightBracketXPortrait + initialX,iPadRightBracketYPortrait, iPadRightBracketWidthPortrait, iPadRightBracketHeightPortrait)];
    [adsScrollView_ addSubview:rightBracket];
    rightBracket = nil;
    
		initialX += 600;
		object = nil;
	
	
	
}
- (void)displayLayoutWithStatusBar:(BOOL)statusBar{
  isStatusBar_ = statusBar;
    UIWindow *rootWindow = [[UIApplication sharedApplication] keyWindow];
  //rootWindow.transform = CGAffineTransformIdentity;
  //[rootWindow setBounds:CGRectMake(0.0, 0.0, 320, 480)];
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    [rootWindow addSubview:self];
  }else {
    containerView_ = [[UIView alloc] initWithFrame:CGRectMake(iPadViewX, iPadViewY, iPadViewWidth, iPadViewHeight)];
    [containerView_ addSubview:self];
    [rootWindow addSubview:containerView_];
  }
  self.transform = CGAffineTransformIdentity;
  [self setBounds:CGRectMake(portraitViewX, portraitViewY, portrtaitViewWidth, portraitViewHeight)];
  [self setFrame:CGRectMake(portraitViewX, portraitViewY, portrtaitViewWidth, portraitViewHeight)];
  [self setCenter:CGPointMake(160, -230)];
  
  if([[FAADNetwork sharedFAADNetwork] currentDevice] == iPhone){
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.75];
    if(isStatusBar_){
         [self setCenter:CGPointMake(portraitViewWithStatusBarCenterX, portraitViewWithStatusBarCenterY)];
    }else{
         [self setCenter:CGPointMake(portraitViewWithoutStatusBarCenterX, portraitViewWithoutStatusBarCenterY)];
    }
 
    [UIView commitAnimations];
  
  }else{
  
    [self setFrame:CGRectMake(0, 0, iPadPortraitViewWidth, iPadPortraitViewHeight)];
    [self setCenter:CGPointMake(iPadPortraitViewCenterX, iPadPortraitViewCenterY)];
  }
 
}


- (void)downloadOfferForId:(int)offerId{
  if(offerClickedWebService_ == nil){
    offerClickedWebService_ = [[FAADOfferClickedWebService alloc]init];
  }
  [offerClickedWebService_ sendRequestWithOfferNumber:offerId];
  
}


//Scroll View Delegate function will be called on each scroll
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
	[closeButton_ release];
	[downloadButton_ release];
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
