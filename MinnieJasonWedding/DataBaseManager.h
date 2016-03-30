//
//  DataBaseManager.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreData.h"

@interface DataBaseManager : NSObject

+ (DataBaseManager *)sharedInstance;
- (NSArray <StoreData *> *)loadBuildInDataWithType:(StoreType)type;
- (NSArray <StoreData *> *)loadUserDataWithType:(StoreType)type;
- (StoreData *)insertUserStoreDataWithStoreData:(NSDictionary <NSString*, NSString*> *)storeDataDictionary withType:(StoreType)type; // will return StoreID

@end
