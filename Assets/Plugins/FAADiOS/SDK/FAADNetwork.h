//
//  FAADNetwork.h
//  FAADNetworkSDK
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved
//

/**
 * FAADNetwork class which provides the interface for the developer to integrate SDK within the application
 *
 */

#import <Foundation/Foundation.h>



@class FAADAdsController;
@class FAADNetworkWebService;
@class FAADOfferClickedWebService;
@class FAADTrackingWebService;
@class FAADKeyValuePairWebService;
@interface FAADNetwork : NSObject {
@private
	NSString *integrationKey_;                      //application Integration Key provided by the server
	NSString *secretKey_;                           //application Secret Key provided by the server 
    FAADAdsController *faadAds_;                    //faadAds controller
    FAADNetworkWebService *faadNetworkService_;     //faadNetwork Service
    FAADOfferClickedWebService *faadOfferClicked_;  //the offer clicked service
    int currentDevice_; //0 for iPhone and 1 for iPad //TODO make it an enum
    FAADTrackingWebService *faadTrackingWebService_;
    NSString *faadCallBackGameObject_;
    FAADKeyValuePairWebService *keyValuePairWebService_;
    NSString *keyValueCallBackMethod_;
    NSString *keyValueCallBackGameObject_;
}

@property (retain,nonatomic) NSString *integrationKey;
@property (retain,nonatomic) NSString *secretKey;
@property (retain,nonatomic) FAADAdsController *faadAds;
@property (retain,nonatomic) FAADNetworkWebService *faadNetworkService;
@property (retain,nonatomic) FAADOfferClickedWebService *faadOfferClicked;
@property int currentDevice;
@property (retain,nonatomic) FAADTrackingWebService *faadTrackingWebService;
@property (retain,nonatomic) NSString * faadCallBackGameObject;
@property (retain,nonatomic) FAADKeyValuePairWebService *keyValuePairWebService;
@property (retain,nonatomic) NSString *keyValueCallBackMethod;
@property (retain,nonatomic) NSString *keyValueCallBackGameObject;
/**
 * function to make the network class singleton
 */
+ (FAADNetwork*)sharedFAADNetwork;

+ (id)alloc;

/**
 * function which connects with the faad server |integrationKey| contains the integration key 
 * and |secretKey| contains the secret key provided by the server
 */
- (void)connectWithIntegrationKey:(NSString*)integrationKey andSecretKey:(NSString*)secretKey;

/**
 * defaul initialzer method
 */
- (id)init;

/**
 * default notifications for the FAAD SDK this method registers thoses notifications with
 * Notification Center
 */
- (void)registerForFAADNotifications;

/**
 * this method removes the observer for the notifications registered for the FAAD SDK default 
 * notifications
 *
 */
- (void)unRegisterForFAADNotifications;

/**
 * method to display the landscape Ads in the application
 */
 
- (void)displayLandscapeAdsWithStatusBar:(BOOL)statusBar;
/**
 * method to display the portrait Ads in the application
 */
- (void)displayPortraitAdsWithStatusBar:(BOOL)statusBar;
/**
 * method which gives the raw feed to the developer in NSDictionary Object returned 
 * to the notification provided in the |feedsCallback| parameter
 *
 */
- (void)getNetworkFeeds:(NSString*)feedsCallback;
/**
 * method which will download the requested feedID as requested by the developer.
 *
 */
- (void)downloadFeedWithId:(int)feedId;																																			

/**
 * method checks for the device type. ipad or iphone
 *
 */

- (void)checkforDevice;

/**
 * method which process FAAD Tracking services
 */
- (void)processFAADTracking;
/**
 * method to remove the notifications registered for internal KeyvaluePair download Callback
 */
- (void)removeKeyValuePairNotifications;

/**
 * method called when the keyvalue pairs are downloaded and this methods
 * sends the Key Value pairs to the registered game object
 */
- (void)keyValuePairsReceived:(NSNotification*)notifyObj;

/**
 * method to register the notifications for internal KeyValuePair download callback
 *
 */

- (void)registerForKeyValueNotifications;

/**
 * method to get the KeyValue pairs for |gameObjectName| and |callBack| for 
 * unity Only.
 */

- (void)getKeyValuePairsForGameObject:(NSString *)gameObjectName forCallBack:(NSString*)callBack;@end
