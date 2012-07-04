//
//  NBSImageDownloader.m
//  NBSHTTPRequest
//
//  Created by Shakeel Nasir on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NBSImageDownloader.h"

NSString *const NBSImageDownloadStartNotification = @"NBSImageDownloadStartNotification";
NSString *const NBSImageDownloadStopNotification = @"NBSImageDownloadStopNotification";

@implementation NBSImageDownloader
@synthesize urlString_;
@synthesize delegate_;
@synthesize connection;
@synthesize imageData;
@synthesize userInfo;



+ (id)downloaderWithURL:(NSURL *)url delegate:(id<NBSImageDownloaderDelegate>)delegate{

    return [[self class] downloaderWithURL:url delegate:delegate userInfo:nil];

}

+ (id)downloaderWithURL:(NSURL *)url delegate:(id<NBSImageDownloaderDelegate>)delegate userInfo:(id)userInfo
{
    NBSImageDownloader *downloader = [[[NBSImageDownloader alloc] init] autorelease];
    downloader.urlString_ = url;
    downloader.delegate_ = delegate;
    downloader.userInfo = userInfo;
    
    [downloader performSelectorOnMainThread:@selector(startDownload) withObject:nil waitUntilDone:YES];
    return downloader;
}


- (void)startDownload{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:urlString_ cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES] autorelease] ;
  
    [request release];
    
    if(connection){
        self.imageData = [NSMutableData data];
        [[NSNotificationCenter defaultCenter] postNotificationName:NBSImageDownloadStartNotification object:nil];
    }else{
        if ([delegate_ respondsToSelector:@selector(imageDownloader:didFailWithError:)])
        {
            [delegate_ performSelector:@selector(imageDownloader:didFailWithError:) withObject:self withObject:nil];
        }
    }

}
- (void)cancelDownload{
    if(connection){
        [connection cancel];
        self.connection = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NBSImageDownloadStopNotification object:nil];
    }
}


#pragma connection methods

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    [imageData appendData:data];
}

#pragma GCC diagnostic ignored "-Wundeclared-selector"
- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    self.connection = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NBSImageDownloadStopNotification object:nil];
    
    if ([delegate_ respondsToSelector:@selector(imageDownloaderDidFinish:)])
    {
        [delegate_ performSelector:@selector(imageDownloaderDidFinish:) withObject:self];
    }
    
    if ([delegate_ respondsToSelector:@selector(imageDownloader:didFinishWithImage:)])
    {
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        [delegate_ performSelector:@selector(imageDownloader:didFinishWithImage:) withObject:self withObject:image];
        [image release];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NBSImageDownloadStopNotification object:nil];
    
    if ([delegate_ respondsToSelector:@selector(imageDownloader:didFailWithError:)])
    {
        [delegate_ performSelector:@selector(imageDownloader:didFailWithError:) withObject:self withObject:error];
    }
    
    self.connection = nil;
    self.imageData = nil;
}



- (void) dealloc {
	[urlString_ release];
  delegate_ = nil;
  //[connection release];
  [imageData release];
	[super dealloc];
}

@end
