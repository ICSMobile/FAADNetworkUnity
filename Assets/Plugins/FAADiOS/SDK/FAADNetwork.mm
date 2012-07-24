//
//  FAADNetwork.m
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
#import "FAADNetwork.h"
#import "FAADCommon.h"
#import "FAADAdsController.h"
#import "FAADNetworkWebService.h"
#import "FAADOfferClickedWebService.h"
#import "FAADKeyValuePairWebService.h"
@implementation FAADNetwork
static FAADNetwork *sharedFAADNetwork_ = nil;

@synthesize integrationKey = integrationKey_;
@synthesize secretKey = secretKey_;
@synthesize faadAds = faadAds_;
@synthesize faadNetworkService = faadNetworkService_;
@synthesize faadOfferClicked = faadOfferClicked_;
@synthesize currentDevice= currentDevice_;
@synthesize faadTrackingWebService = faadTrackingWebService_;
@synthesize keyValuePairWebService = keyValuePairWebService_;
@synthesize faadCallBackGameObject = faadCallBackGameObject_;
@synthesize keyValueCallBackMethod = keyValueCallBackMethod_;
@synthesize keyValueCallBackGameObject = keyValueCallBackGameObject_;


- (void)checkforDevice{
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    currentDevice_ = 1;
  }
  else{
  currentDevice_ = 0;
  }
  
}
- (NSDictionary*)getConnectionParameters{
	
  NSLocale *locale = [NSLocale currentLocale];
  NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
	UIDevice *device = [UIDevice currentDevice];
	NSString *identifier = [OpenUDID value];
    NSString *macAddress = [device getMacAddress];
  //  NSLog(@"the mac address is %@",macAddress);
    NSString *model = [device model];
	//	NSString *systemVersion = [device systemVersion];
	//	NSString *deviceName = [device platformString];
	//	NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)NSLog(@"the device name is %@",model);
    model = [model stringByReplacingOccurrencesOfString:@" " withString:@""];
    //	NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
	NSString *hashCode =[FAADUtility getMD5hashCode:[NSString stringWithFormat:@"%@%@%@",identifier,[self integrationKey],[self secretKey]]];
	NSMutableDictionary *parameters = [[NSMutableDictionary alloc]
                                       initWithObjectsAndKeys:hashCode,kHashCode,
                                       identifier,kDeviceId,
                                       [self integrationKey],kAppIntegrationKey,countryCode,kFAADCountryCode,macAddress,kMacAddress,model,kDeviceType,nil];
	return [parameters autorelease];
	
}

+ (FAADNetwork*)sharedFAADNetwork{
	@synchronized([FAADNetwork class]){
		if(!sharedFAADNetwork_){
		[[self alloc] init];
		}
	}
	return sharedFAADNetwork_;
}

+ (id)alloc{
	@synchronized([FAADNetwork class]){
		NSAssert(sharedFAADNetwork_ == nil, @"Attempt to allocate a second instance of a singleton");
		sharedFAADNetwork_ = [super alloc];
		return sharedFAADNetwork_;
	}
	return nil;
}

-(id)init{
	self = [super init];
	if(self != nil){
	}
	return self;
}


- (void)connectWithIntegrationKey:(NSString*)integrationKey andSecretKey:(NSString*)secretKey{
	[self checkforDevice];
	[self registerForFAADNotifications];
    [[FAADTracking sharedManager] registerForDeviceNotifications];
  
  if(([integrationKey length] != 0) && ([secretKey length] != 0)){
		self.integrationKey = [integrationKey copy];
		self.secretKey		= [secretKey copy];
		[[FAADConnectWebService sharedFAADConnectWebService] sendRequestWithParameter:[self getConnectionParameters]];
	}else {
		//NSLog(@"FAAD Authentication Error. Please check your implementation of connectWithIntegrationKey");
	}

}

- (void)getKeyValuePairsForGameObject:(NSString *)gameObjectName forCallBack:(NSString*)callBack{
    self.keyValueCallBackMethod = [NSString stringWithString:callBack];
    self.keyValueCallBackGameObject = [NSString stringWithString:gameObjectName];
    
    if(keyValuePairWebService_ == nil){
        keyValuePairWebService_ = [[FAADKeyValuePairWebService alloc] init];
    }
    
    [keyValuePairWebService_ getKeyValuePairswithCallBack:kSplashKitKeyValuePairs];
    [self registerForKeyValueNotifications];

    
}
- (void)getKeyValuePairs:(NSString*)keyValuePairsCallBack{
    //self.keyValueCallBack = [NSString stringWithString:keyValuePairsCallBack];
    if(keyValuePairWebService_ == nil){
        keyValuePairWebService_ = [[FAADKeyValuePairWebService alloc] init];
    }
    // [faadNetworkService_ getNetworkFeedswithCallBack:feedsCallback];
    //[keyValuePairWebService_ getKeyValuePairswithCallBack:self.keyValueCallBack];
    [self registerForKeyValueNotifications];
}

- (void)FAADNetworkConnected:(NSNotification*)notifyObject{
	NSLog(@"FAADConnected");
    UnitySendMessage([faadCallBackGameObject_ UTF8String], "FAADConnected",nil);
    [self processFAADTracking];
 //   [[FAADNetwork sharedFAADNetwork] getKeyValuePairs:kSplashKitKeyValuePairs];
}

- (void)FAADNetworkFailedToConnect:(NSNotification*)notifyObject{
	NSLog(@"Failed to connect with FAADNetwork");

}

- (void)registerForFAADNotifications{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FAADNetworkConnected:) name:kFAADConnectSuccessfullNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FAADNetworkFailedToConnect:) name:kFAADConnectFailureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FAADFeedViewClosed) name:kFAADFeedViewClosed object:nil];
    
}

-(void)registerForKeyValueNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyValuePairsReceived:) name:kSplashKitKeyValuePairs object:nil];
}



- (void)unRegisterForFAADNotifications{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADConnectSuccessfullNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADConnectFailureNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFAADFeedViewClosed object:nil];
}

-(void)keyValuePairsReceived:(NSNotification*)notifyObj{
    [self removeKeyValuePairNotifications];
    NSString *keyValue = [notifyObj object];
    NSLog(@"the key value pair is %@",keyValue);
    
   // NSString *gameObject = [self.keyValueCallBackGameObject;
    UnitySendMessage([self.keyValueCallBackGameObject UTF8String],[self.keyValueCallBackMethod UTF8String],[keyValue UTF8String]);
}

-(void)removeKeyValuePairNotifications{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSplashKitKeyValuePairs object:nil];
}
- (void)FAADFeedViewClosed{
 //   NSLog(@"FAAD Feed View Closed");
     UnitySendMessage([faadCallBackGameObject_ UTF8String], "FAADFeedViewClosed",nil);
}

- (void)displayPortraitAdsWithStatusBar:(BOOL)statusBar{
    if(faadAds_ == nil){
        faadAds_ = [[FAADAdsController alloc] init];
    }
  [faadAds_ displayPortraitAdsWithStatusBar:statusBar];
    
}
- (void)displayLandscapeAdsWithStatusBar:(BOOL)statusBar{
    if(faadAds_ == nil){
        faadAds_ = [[FAADAdsController alloc]
                    init];
    }
    [faadAds_ displayLandScapeAdsWithStatusBar:statusBar];

}

- (void)getNetworkFeeds:(NSString*)feedsCallback{
    if(faadNetworkService_ == nil){
        faadNetworkService_ = [[FAADNetworkWebService alloc] init];
    }
    [faadNetworkService_ getNetworkFeedswithCallBack:feedsCallback];
}

- (void)downloadFeedWithId:(int)feedId{
    if(faadOfferClicked_ == nil){
        faadOfferClicked_ = [[FAADOfferClickedWebService alloc] init];
    }
    [faadOfferClicked_ sendRequestWithOfferNumber:feedId];
}																
- (void)processFAADTracking{
    if(faadTrackingWebService_ == nil){
        faadTrackingWebService_ = [[FAADTrackingWebService alloc] init];
    }
    [faadTrackingWebService_ processTracking];
    

}
- (void)dealloc{
	[self unRegisterForFAADNotifications];
	[integrationKey_ release];
	[secretKey_ release];
    [faadAds_ release];
	[faadNetworkService_ release];
    [faadOfferClicked_ release];
    [faadTrackingWebService_ release];
    [keyValuePairWebService_ release];
    [faadCallBackGameObject_ release];
    [keyValueCallBackMethod_ release];
    [keyValueCallBackGameObject_ release];
    [sharedFAADNetwork_ release];
    
    [super dealloc];
}



//UNITY INTERFACE FOR FAAD.
//static FAADNetwork *faadNetworkDelegate = nil;

extern "C" {
    
    NSString* CreateNSString (const char* string);
    char* MakeStringCopy (const char* string);

    void _connectWithIntegrationKeyAndSecretKey(const char *integrationKey , const char *secretKey);
    void _displayLandScapeAds();
    void _displayPortraitAds();
    void _setCallbackGameObject(const char* handlerName);
    void _getKeyValuePairsForGameObject(const char * gameObjectName, const char *callBack);
    
    // Converts C style string to NSString
    NSString* CreateNSString (const char* string)
    {
        if (string)
            return [NSString stringWithUTF8String: string];
        else
            return [NSString stringWithUTF8String: ""];
    }
    
    // Helper method to create C string copy
    char* MakeStringCopy (const char* string)
    {
        if (string == NULL)
            return NULL;
        
        char* res = (char*)malloc(strlen(string) + 1);
        strcpy(res, string);
        return res;
    }
    
    
    void _connectWithIntegrationKeyAndSecretKey(const char *integrationKey , const char *secretKey){
        [[FAADNetwork sharedFAADNetwork] connectWithIntegrationKey:CreateNSString(integrationKey) andSecretKey:CreateNSString(secretKey)];
    }
    
    
    void _displayLandScapeAds(){
        [[FAADNetwork sharedFAADNetwork] displayLandscapeAdsWithStatusBar:NO];
    }
    
    void _displayPortraitAds(){
        [[FAADNetwork sharedFAADNetwork] displayPortraitAdsWithStatusBar:NO];
    }

    void _setCallbackGameObject(const char* handlerName){
		[[FAADNetwork sharedFAADNetwork] setFaadCallBackGameObject:[NSString stringWithUTF8String:handlerName]];
		NSLog(@"callbackHandlerName: %@", [[FAADNetwork sharedFAADNetwork] faadCallBackGameObject]);
	}
    
    void _getKeyValuePairsForGameObject(const char * gameObjectName, const char *callBack){
        [[FAADNetwork sharedFAADNetwork] getKeyValuePairsForGameObject:CreateNSString(gameObjectName) forCallBack:CreateNSString(callBack)];
    }
}

@end
