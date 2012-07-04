//
//  WebImageView.m
//  FAADNetworkSDK
//
//  Created by Shakeel Asim on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+web.h"
#import "NBSImageManager.h"
#import "FAADCommon.h"

@implementation UIImageView (Cache)

- (void)setImageWithUrl:(NSString*)url {
    [self setImageWithUrl:url placeHolder:nil];
}

- (void)setImageWithUrl:(NSString*)url placeHolder:(UIImage*)placeHolder {
    NBSImageManager *imageManager = [NBSImageManager sharedManager];
    
    self.image = placeHolder;
	if(url!= nil){
        [imageManager downloadImageFromURL:[NSURL URLWithString:url] delegate:self];
    }else{
        
    }
    
}


- (void)webImageManager:(NBSImageManager *)imageManager didFinishWithImage:(UIImage*)image{
    self.image = image;
}

- (void)webImageManager:(NBSImageManager *)didCancel{
    self.image = [UIImage imageNamed:iconImageplaceHolder];

}
@end
