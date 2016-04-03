//
//  StoreData.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "StoreData.h"

@implementation StoreData

- (instancetype)initWithDictionary:(NSDictionary <NSString *, NSString *> *)dictionary
{
    self = [super init];
    if (self) {
        _storeName = dictionary[kStoreName];
        _phoneNumber = dictionary[kPhoneNumber];
        _address = dictionary[kAddress];
        _webAddress = dictionary[kWebAddress];
        _type = [dictionary[kType] integerValue];
        _isFavorites = [dictionary[kIsFavorites] boolValue];
        _storeID = dictionary[kStoreID];
    }
    return self;
}

- (NSDictionary <NSString *, NSString *> *)storeDataDictionary
{
    NSMutableDictionary *storeDataMutableDictionary = [[NSMutableDictionary alloc] init];
    storeDataMutableDictionary[kStoreName] = _storeName;
    storeDataMutableDictionary[kPhoneNumber] = _phoneNumber;
    storeDataMutableDictionary[kAddress] = _address;
    storeDataMutableDictionary[kWebAddress] = _webAddress;
    storeDataMutableDictionary[kType] = @(_type);
    storeDataMutableDictionary[kIsFavorites] = @(_isFavorites);
    storeDataMutableDictionary[kStoreID] = _storeID;
    return [[NSDictionary alloc] initWithDictionary:storeDataMutableDictionary];
}

@end
