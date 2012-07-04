//
//  WebImageView.h
//  FAADNetworkSDK
//
//  Created by Shakeel Asim on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBSImageManagerDelegate.h"

@interface UIImageView (Cache) <NBSImageManagerDelegate>

- (void)setImageWithUrl:(NSString*)url;
- (void)setImageWithUrl:(NSString*)url placeHolder:(UIImage*)placeHolder;
@end
