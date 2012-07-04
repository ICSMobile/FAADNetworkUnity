//
//  FAADSessionObject.h
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FAADSessionObject : NSObject {
    @private
  NSInteger primaryKey_;
  NSString *sessionText_;
  NSInteger isCompleted_;
  
}
@property NSInteger primaryKey;
@property (nonatomic,retain) NSString *sessionText;
@property NSInteger isCompleted;
@end
