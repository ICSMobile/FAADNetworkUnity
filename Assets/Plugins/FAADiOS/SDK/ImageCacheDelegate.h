//
//  ImageCacheDelegate.h
//  FAADNetworkSampleApp
//
//  Created by Shakeel Asim on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageCache;

@protocol ImageCacheDelegate <NSObject>

@optional
- (void)imageCache:(ImageCache *)imageCache didFindImage:(UIImage *)image forKey:(NSString *)key userInfo:(NSDictionary *)info;
- (void)imageCache:(ImageCache *)imageCache didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info;
@end
