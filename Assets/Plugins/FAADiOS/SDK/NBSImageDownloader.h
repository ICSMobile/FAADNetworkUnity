//
//  NBSImageDownloader.h
//  NBSHTTPRequest
//
//  Created by Shakeel Nasir on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBSImageDownloaderDelegate.h"

extern NSString *const NBSImageDownloadStartNotification;
extern NSString *const NBSImageDownloadStopNotification;
@interface NBSImageDownloader : NSOperation {
	NSURL * urlString_;
	id <NBSImageDownloaderDelegate> delegate_;
    NSURLConnection *connection;
    NSMutableData *imageData;
    id userInfo;
    BOOL isCancel;
    
}

@property (copy) NSURL * urlString_;
@property (assign) id delegate_;
@property (nonatomic,retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) id userInfo;


+ (id)downloaderWithURL:(NSURL *)url delegate:(id<NBSImageDownloaderDelegate>)delegate;
+ (id)downloaderWithURL:(NSURL *)url delegate:(id<NBSImageDownloaderDelegate>)delegate userInfo:(id)userInfo;
- (void)startDownload;
- (void)cancelDownload;
@end
