//
//  NBSImageDownloaderDelegate.h
//  NBSHTTPRequest
//
//  Created by Shakeel Nasir on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NBSImageDownloader;
@protocol NBSImageDownloaderDelegate <NSObject>

@optional

- (void)imageDownloaderDidFinish:(NBSImageDownloader *)downloader;
- (void)imageDownloader:(NBSImageDownloader *)downloader didFinishWithImage:(UIImage *)image;
- (void)imageDownloader:(NBSImageDownloader *)downloader didFailWithError:(NSError *)error;
@end
