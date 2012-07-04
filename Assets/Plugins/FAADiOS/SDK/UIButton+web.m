//
//  UIButton+web.m
//  FAADFunChat
//
//  Created by asad.rehman on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIButton+web.h"
#import "NBSImageManager.h"
#import <objc/runtime.h>


@implementation UIButton (ButtonCache)
static const char notificationKey;

@dynamic callBackNotification;


- (NSString*)callBackNotification{
  return objc_getAssociatedObject(self,&notificationKey);
}

- (void)setCallBackNotification:(NSString*)callBackNotification{
  objc_setAssociatedObject(self, &notificationKey, callBackNotification, OBJC_ASSOCIATION_RETAIN);
}
- (void)setImageWithUrl:(NSString*)url {
  [self setImageWithUrl:url placeHolder:nil];
}


- (void)setImageWithUrl:(NSString *)url andCallBack:(NSString *)notification{
  [self setImageWithUrl:url placeHolder:nil];
  [self setCallBackNotification:notification];
  NSLog(@"image download");
}
- (void)setImageWithUrl:(NSString*)url placeHolder:(UIImage*)placeHolder {
  NBSImageManager *imageManager = [NBSImageManager sharedManager];
///[self setImage:placeHolder forState:UIControlStateNormal];
    [self setBackgroundImage:placeHolder forState:UIControlStateNormal];
  if(url!= nil){
    [imageManager downloadImageFromURL:[NSURL URLWithString:url] delegate:self];
  }
  
}


- (void)webImageManager:(NBSImageManager *)imageManager didFinishWithImage:(UIImage*)image{
  if([self callBackNotification] == nil){
 // [self setImage:image forState:UIControlStateNormal];
      [self setBackgroundImage:image forState:UIControlStateNormal];
  }else{
  NSLog(@"the call back is %@",[self callBackNotification]);
  [[NSNotificationCenter defaultCenter] postNotificationName:[self callBackNotification] object:image];
  }
  }

@end
