//
//  StoreData.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStoreName      @"storeName"
#define kPhoneNumber    @"phoneNumber"
#define kAddress        @"address"
#define kWebAddress     @"webAddress"
#define kType           @"type"
#define kIsFavorites    @"isFavorites"
#define kStoreID        @"storeID"




typedef enum : NSUInteger {
    StoreTypeDress, // 婚紗公司
    StoreTypePhoto, // 攝影公司
    StoreTypePrint, // 印刷公司
    StoreTypeActivity, // 婚禮企劃
} StoreType;

@interface StoreData : NSObject

@property (nonatomic, readonly) NSString *storeName;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *webAddress;
@property (nonatomic, readonly) StoreType type;
@property (nonatomic) BOOL isFavorites;
@property (nonatomic, retain) NSString *storeID;

- (instancetype)initWithDictionary:(NSDictionary <NSString *, NSString *> *)dictionary;

@end
