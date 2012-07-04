//
//  UIButton+web.h
//  FAADFunChat
//
//  Created by asad.rehman on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NBSImageManagerDelegate.h"

@interface UIButton (ButtonCache) <NBSImageManagerDelegate>

@property (nonatomic,retain) NSString* callBackNotification;
- (void)setImageWithUrl:(NSString*)url;
- (void)setImageWithUrl:(NSString*)url placeHolder:(UIImage*)placeHolder;
- (void)setImageWithUrl:(NSString *)url andCallBack:(NSString *)notification;

@end
