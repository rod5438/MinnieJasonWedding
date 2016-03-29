//
//  DataBaseManager.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "DataBaseManager.h"

#define NUMBER_OF_USER_DATA         @"numberOfUserData"
#define NUMBER_OF_BUILD_IN_DATA     @"numberOfBuildIndata"

@implementation DataBaseManager

+ (DataBaseManager *)sharedInstance
{
    static DataBaseManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{NUMBER_OF_USER_DATA : @(0)}];
        [self initBuildInDataToDB];
    }
    return self;
}

- (void)initBuildInDataToDB
{
    NSArray <NSDictionary *> *buildInDataDictionary = @[
                             @{kStoreName:@"亞太麗緻婚紗",
                               kPhoneNumber:@"02-2761-6727",
                               kWebAddress:@"http://apiwi.com/",
                               kAddress:@"105台北市松山區八德路四段666號",
                               kType:@(StoreTypeDress),
                               kIsFavorites:@(YES),
                               kStoreID:[self getKeyForBuildInStoreDataIndex:0]},
                             @{kStoreName:@"CH WEDDING經典婚紗",
                               kPhoneNumber:@"02-2702-7685",
                               kWebAddress:@"http://www.c-hwedding.com/",
                               kAddress:@"106台北市大安區安和路一段133號",
                               kType:@(StoreTypeDress),
                               kIsFavorites:@(NO),
                               kStoreID:[self getKeyForBuildInStoreDataIndex:1]},
                             ];
    [[NSUserDefaults standardUserDefaults] setObject:@(buildInDataDictionary.count) forKey:NUMBER_OF_BUILD_IN_DATA];

    for (NSInteger index = 0; index < [self numberOfBuildInData] ; index ++) {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{buildInDataDictionary[index][kStoreID] : buildInDataDictionary[index]}];
    }
}

- (NSArray <StoreData *> *)loadBuildInData
{
    NSMutableArray *buildInDatas = [[NSMutableArray alloc] init];
    for (NSInteger index = 0 ; index < [self numberOfBuildInData] ; index++) {
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyForBuildInStoreDataIndex:index]];
        StoreData *data = [[StoreData alloc] initWithDictionary:dictionary];
        if (data) {
            [buildInDatas addObject:data];
        }
    }
    return [[NSArray alloc] initWithArray:buildInDatas];
}

- (NSArray <StoreData *> *)loadBuildInDataWithType:(StoreType)type
{
    NSArray *allBuildInData;
    NSMutableArray <StoreData *> *filterBuildInData = [[NSMutableArray alloc] init];
    allBuildInData = [self loadBuildInData];
    for (StoreData *data in allBuildInData) {
        if (data.type == type) {
            [filterBuildInData addObject:data];
        }
    }
    return [[NSArray alloc] initWithArray:filterBuildInData];
}

- (NSArray <StoreData *> *)loadUserData
{
    NSMutableArray *userDatas = [[NSMutableArray alloc] init];
    for (NSInteger index = 0 ; index < [self numberOfUserData] ; index++) {
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyForUserStoreDataIndex:index]];
        StoreData *data = [[StoreData alloc] initWithDictionary:dictionary];
        if (data) {
            [userDatas addObject:data];
        }
    }
    return [[NSArray alloc] initWithArray:userDatas];
}

- (NSArray <StoreData *> *)loadUserDataWithType:(StoreType)type
{
    NSArray *allUserData;
    NSMutableArray <StoreData *> *filterUserData = [[NSMutableArray alloc] init];
    allUserData = [self loadUserData];
    for (StoreData *data in allUserData) {
        if (data.type == type) {
            [filterUserData addObject:data];
        }
    }
    return [[NSArray alloc] initWithArray:filterUserData];
}

- (NSString *)getKeyForUserStoreDataIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"UserStore_%ld",index];
}

- (NSString *)getKeyForBuildInStoreDataIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"BuildInStore_%ld",index];
}

- (NSInteger)numberOfUserData
{
    NSNumber *numberOfUserData = [[NSUserDefaults standardUserDefaults] objectForKey:NUMBER_OF_USER_DATA];
    return [numberOfUserData integerValue];
}

- (NSInteger)numberOfBuildInData
{
    NSNumber *numberOfBuildInData = [[NSUserDefaults standardUserDefaults] objectForKey:NUMBER_OF_BUILD_IN_DATA];
    return [numberOfBuildInData integerValue];
}
@end
