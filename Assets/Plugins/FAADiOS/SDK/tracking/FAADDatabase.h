//
//  FAADDatabase.h
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface FAADDatabase : NSObject {
  sqlite3 *database_;
}

- (void)createEditableCopyOfDatabaseIfNeeded;
- (int)storeSessionInDatabase:(NSString *)sessionData;
- (NSMutableArray *)getSessionsStoredInDB;
- (void)initDatabase;
- (void)updateSessionWithId:(int)sessionId;
@end
