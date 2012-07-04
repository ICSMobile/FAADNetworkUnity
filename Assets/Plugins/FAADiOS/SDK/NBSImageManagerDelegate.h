//
//  NBSImageManagerDelegate.h
//  FAADNetworkSampleApp
//
//  Created by Shakeel Nasir on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
@class NBSImageManager;

@protocol NBSImageManagerDelegate <NSObject>

@optional
- (void)webImageManager:(NBSImageManager *)imageManager didFinishWithImage:(UIImage*)image;
- (void)webImageManager:(NBSImageManager *)imageManager didFailWithError:(NSError*)error;
- (void)webImageManager:(NBSImageManager *)didCancel;


@end
