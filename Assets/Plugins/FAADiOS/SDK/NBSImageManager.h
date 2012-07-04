//
//  NBSImageManager.h
//  FAADNetworkSampleApp
//
//  Created by Shakeel Nasir on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBSImageDownloaderDelegate.h"
#import "NBSImageManagerDelegate.h"
#import "ImageCacheDelegate.h"

@interface NBSImageManager : NSObject<NBSImageDownloaderDelegate,ImageCacheDelegate> {
    
    NSMutableArray *delegates_;
    NSMutableArray *downloaders_;
    NSMutableDictionary *urlDownloaders_;
    NSMutableArray *failedUrls_;
}
+ (id)sharedManager;
- (void)downloadImageFromURL:(NSURL *)url delegate:(id<NBSImageManagerDelegate>)delegate;
- (void)downloadImageFromURL:(NSURL *)url delegate:(id<NBSImageManagerDelegate>)delegate retryFailed:(BOOL)retryFailed;
- (void)cleanDelegates;
@end
