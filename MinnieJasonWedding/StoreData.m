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

@end
