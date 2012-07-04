//
//  FAADDatabase.m
//  FAADNetworkSampleApp
//
//  Created by asad.rehman on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "FAADDatabase.h"
#import "FAADSessionObject.h"

@implementation FAADDatabase

- (id)init{
  if(self == [super init]){
    [self createEditableCopyOfDatabaseIfNeeded];
    [self initDatabase];
  }
  return self;
}

- (void)initDatabase{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *path = [documentsDirectory stringByAppendingPathComponent:@"faadtracking.sqlite"];
  // Open the database. The database was prepared outside the application.
  if (sqlite3_open([path UTF8String], &database_) != SQLITE_OK) {
    sqlite3_close(database_);
     NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database_));
  }


}
- (void)createEditableCopyOfDatabaseIfNeeded{
  BOOL success;
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *documentDirectory = [paths objectAtIndex:0];
  NSString *writeableDBPath = [documentDirectory stringByAppendingPathComponent:@"faadtracking.sqlite"];
  success = [fileManager fileExistsAtPath:writeableDBPath];
  if(success){
    return;
  }
  NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"faadtracking.sqlite"];
  success = [fileManager copyItemAtPath:defaultDBPath toPath:writeableDBPath error:&error];
  
  if(!success){
    NSAssert(0,@"Failed to create writable database file with message '%@'",[error localizedDescription]);
                                                                            
  }
}



- (NSMutableArray *)getSessionsStoredInDB{
  NSMutableArray *sessions = [[NSMutableArray alloc] init];
  const char *sql_query = "select * from FAADTracking where is_Completed = 0";
  sqlite3_stmt *statement = nil; 
    if(sqlite3_prepare_v2(database_, sql_query, -1, &statement, NULL) == SQLITE_OK){
      while(sqlite3_step(statement) == SQLITE_ROW){
        int primaryKey = sqlite3_column_int(statement, 0);
        NSString *sessionText = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
        int isCompleted = sqlite3_column_int(statement,2);
        FAADSessionObject *object = [[FAADSessionObject alloc] init];
        [object setPrimaryKey:primaryKey];
        [object setSessionText:sessionText];
        [object setIsCompleted:isCompleted];
        [sessions addObject:object];
        [object release];
      }
    
    }
    sqlite3_finalize(statement);
    return sessions;
}


- (int)storeSessionInDatabase:(NSString *)sessionData{

  sqlite3_stmt *insertStatement= nil;
  
  if(insertStatement == nil){
    NSString *sql =[NSString stringWithFormat:@"INSERT INTO FAADTracking (session_data,is_completed) values ('%@',0)",sessionData];
   //    NSLog(@"the query is %@",sql);
    const char *sql_query = [sql UTF8String];
    if(sqlite3_prepare_v2(database_, sql_query, -1, &insertStatement, NULL) != SQLITE_OK){
      NSAssert(0,@"Error:failed to prepare statement with message '%s'",sqlite3_errmsg(database_));
    }
  
  }
  int success = sqlite3_step(insertStatement);

  sqlite3_reset(insertStatement);
  if (success != SQLITE_ERROR) {
    return sqlite3_last_insert_rowid(database_);
  }
  NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database_));

  return 0;
}


- (void)updateSessionWithId:(int)sessionId{
    sqlite3_stmt *updateStatement= nil;
    
    if(updateStatement == nil){
      //  NSString *sql =[NSString stringWithFormat:@"INSERT INTO FAADTracking (session_data,is_completed) values ('%@',0)",sessionData];
        NSString *sql = [NSString stringWithFormat:@"Update FAADTracking set is_Completed = 1 where id =%d",sessionId];
     //   NSLog(@"the query is %@",sql);
        const char *sql_query = [sql UTF8String];
        if(sqlite3_prepare_v2(database_, sql_query, -1, &updateStatement, NULL) != SQLITE_OK){
            NSAssert(0,@"Error:failed to prepare statement with message '%s'",sqlite3_errmsg(database_));
        }
        
    }
    int success = sqlite3_step(updateStatement);
    
    sqlite3_reset(updateStatement);
    if (success != SQLITE_ERROR) {
       // return sqlite3_last_insert_rowid(database_);
    }
   // NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database_));
    
    

}
@end
