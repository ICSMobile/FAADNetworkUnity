//
//  ImageCache.h
//  FAADNetworkSampleApp
//
//  Created by Shakeel Asim on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageCacheDelegate.h"

@interface ImageCache : NSObject {
    NSMutableDictionary *memCache_;
    NSOperationQueue *cacheInQueue,*cacheOutQueue;

}
+ (id)sharedImageCache;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;
- (void)imageForKey:(NSString*)key forDelegate:(id<ImageCacheDelegate>)delegate userInfo:(NSDictionary*)userInfo;
- (void)removeImageForKey:(NSString*)key;
- (void)clearMemory;

@end