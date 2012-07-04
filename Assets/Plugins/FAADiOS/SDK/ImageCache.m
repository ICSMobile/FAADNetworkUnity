//
//  ImageCache.m
//  FAADNetworkSampleApp
//
//  Created by Shakeel Asim on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"
#import "NBSImageDownloader.h"
static ImageCache *sharedCache_;

@implementation ImageCache

- (id)init{
    if((self = [super init])){
        memCache_ = [[NSMutableDictionary alloc] init];
        //operation queue
        cacheInQueue = [[NSOperationQueue alloc] init];
        [cacheInQueue setMaxConcurrentOperationCount:1];
        cacheOutQueue = [[NSOperationQueue alloc] init];
        [cacheOutQueue setMaxConcurrentOperationCount:1];
        
    }
    return self;
}

- (void)dealloc{
  [memCache_ release];
  [cacheInQueue release];
  [cacheOutQueue release];
  [super dealloc];
}

+ (id)sharedImageCache{
    if(sharedCache_ == nil){
        sharedCache_ = [[ImageCache alloc]init];
        
    }
    return sharedCache_;
}



- (void)storeImage:(UIImage *)image forKey:(NSString *)key{
    if(image){
        [memCache_ setObject:image forKey:key];
    }
}


- (void)imageForKey:(NSString*)key forDelegate:(id<ImageCacheDelegate>)delegate userInfo:(NSDictionary*)userInfo{
    if(!delegate){
        return;
    }
    if(!key){
        if([delegate respondsToSelector:@selector(imageCache:didNotFindImageForKey:userInfo:)]){
            [delegate imageCache:self didNotFindImageForKey:key userInfo:userInfo];
        }
        return;
    }

    UIImage *image = [memCache_ objectForKey:key];
    if(image){
        if([delegate respondsToSelector:@selector(imageCache:didFindImage:forKey:userInfo:)]){
            [delegate imageCache:self didFindImage:image forKey:key userInfo:userInfo];
        }
        return;
    }else{
            if([delegate respondsToSelector:@selector(imageCache:didNotFindImageForKey:userInfo:)]){
            [delegate imageCache:self didNotFindImageForKey:key userInfo:userInfo];
        }
    }
    
    
}


- (void)removeImageForKey:(NSString*)key{
  if (key == nil)
  {
    return;
  }
	
  [memCache_ removeObjectForKey:key];	

}
- (void)clearMemory{
  [memCache_ removeAllObjects];
}

@end
