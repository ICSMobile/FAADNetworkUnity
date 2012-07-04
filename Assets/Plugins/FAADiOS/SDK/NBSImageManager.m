//
//  NBSImageManager.m
//  FAADNetworkSampleApp
//
//  Created by Shakeel Nasir on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBSImageManager.h"
#import "ImageCache.h"
#import "NBSImageDownloader.h"

static NBSImageManager *sharedImageManager_;

@implementation NBSImageManager

- (id)init{
    if((self = [super init])){
        delegates_ = [[NSMutableArray alloc] init];
        downloaders_ = [[NSMutableArray alloc] init];
        urlDownloaders_ = [[NSMutableDictionary alloc] init];
        failedUrls_ = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc{
  [delegates_ release];
  [downloaders_ release];
  [urlDownloaders_ release];
  [failedUrls_ release];
  [super dealloc];
}

+ (id)sharedManager{
    
    if(sharedImageManager_ == nil){
        sharedImageManager_ = [[NBSImageManager alloc] init];
    }
    return sharedImageManager_;
}


- (void)downloadImageFromURL:(NSURL *)url delegate:(id<NBSImageManagerDelegate>)delegate{
    [self downloadImageFromURL:url delegate:delegate retryFailed:NO];
}

- (void)downloadImageFromURL:(NSURL *)url delegate:(id<NBSImageManagerDelegate>)delegate retryFailed:(BOOL)retryFailed{
    if(!url || !delegate || (!retryFailed && [failedUrls_ containsObject:url])){
        return;
    }
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:delegate, @"delegate", url, @"url",nil];
    [[ImageCache sharedImageCache] imageForKey:[url absoluteString] forDelegate:self userInfo:info];

}



- (void)imageCache:(ImageCache *)imageCache didFindImage:(UIImage *)image forKey:(NSString *)key userInfo:(NSDictionary *)info{
    //NSLog(@"image found from cache");
    id<NBSImageManagerDelegate> delegate = [info objectForKey:@"delegate"];
    if ([delegate respondsToSelector:@selector(webImageManager:didFinishWithImage:)])
    {
        [delegate performSelector:@selector(webImageManager:didFinishWithImage:) withObject:self withObject:image];
    }


}
- (void)cleanDelegates{
    for(int i = 0 ; i < [delegates_ count]; i++){
        NBSImageDownloader *currentDownload = [downloaders_ objectAtIndex:i];
        [currentDownload performSelector:@selector(cancelDownload)];
    }
    for(int i = 0 ; i < [delegates_ count]; i++){
        [delegates_ removeObjectAtIndex:i];
    }
    
    for(int i = 0 ; i < [downloaders_ count]; i++){
        [downloaders_ removeObjectAtIndex:i];
        
    }
    
}
- (void)imageCache:(ImageCache *)imageCache didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info{
    NSString *url = [NSString stringWithString:key];
    [self cleanDelegates];
   
    [urlDownloaders_ removeObjectForKey:url];
    id<NBSImageManagerDelegate> delegate = [info objectForKey:@"delegate"];
    
    NBSImageDownloader *downloader = [urlDownloaders_ objectForKey:url];
    if(!downloader){
        downloader = [NBSImageDownloader downloaderWithURL:[NSURL URLWithString:url ] delegate:self];
        [urlDownloaders_ setObject:downloader forKey:url];
    }
    [delegates_ addObject:delegate];
    [downloaders_ addObject:downloader];
}

- (void)imageDownloadDidCancel:(NBSImageDownloader *)downloader{
    [downloader retain];
    
    for(NSInteger downloaderId = [downloaders_ count] - 1;downloaderId >=0 ;downloaderId--){
        NBSImageDownloader *imgDownloader = [downloaders_ objectAtIndex:downloaderId];
        if(imgDownloader == downloader){
            [downloaders_ removeObjectAtIndex:downloaderId];
            [delegates_ removeObjectAtIndex:downloaderId];
        }
        
    }
}




- (void)imageDownloader:(NBSImageDownloader *)downloader didFinishWithImage:(UIImage *)image{
    [downloader retain];
    
    for(NSInteger downloaderId = [downloaders_ count] - 1;downloaderId >=0 ;downloaderId--){
        NBSImageDownloader *imgDownloader = [downloaders_ objectAtIndex:downloaderId];
        if(imgDownloader == downloader){
            id<NBSImageManagerDelegate> delegate = [delegates_ objectAtIndex:downloaderId];
            
            if(image){
                if([delegate respondsToSelector:@selector(webImageManager:didFinishWithImage:)]){
                   
                    
                    [delegate performSelector:@selector(webImageManager:didFinishWithImage:) withObject:self withObject:image];
            }
            }else{
                if ([delegate respondsToSelector:@selector(webImageManager:didFailWithError:)])
                {
                    [delegate performSelector:@selector(webImageManager:didFailWithError:) withObject:self withObject:nil];
                }
            
            
            }
            [downloaders_ removeObjectAtIndex:downloaderId];
            [delegates_ removeObjectAtIndex:downloaderId];
        }
    
    }
    
    if(image){
        //store the image to cache
        [[ImageCache sharedImageCache] storeImage:image  forKey:[downloader.urlString_ absoluteString]];
    }
}
- (void)imageDownloader:(NBSImageDownloader *)downloader didFailWithError:(NSError *)error{
    //NSLog(@"image download did finish error");
}

@end


