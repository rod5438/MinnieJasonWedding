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
#define BUILD_IN_DATA_VERSION 1 // + 1 會重設 User DB
#define BUILD_IN_DATA_VERSION_KEY   @"buildInDataVersionKey"

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
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{BUILD_IN_DATA_VERSION_KEY : @(0)}];
        [self initBuildInDataToDB];
    }
    return self;
}

- (void)initBuildInDataToDB
{
    NSArray <NSDictionary *> *buildInDataStoreTypeDressArray =
    @[
      @{kStoreName:@"亞太麗緻婚紗",
        kPhoneNumber:@"02-2761-6727",
        kWebAddress:@"http://apiwi.com/",
        kAddress:@"105台北市松山區八德路四段666號",
        kType:@(StoreTypeDress),
        kIsFavorites:@(NO)},
      @{kStoreName:@"CH WEDDING經典婚紗",
        kPhoneNumber:@"02-2702-7685",
        kWebAddress:@"http://www.c-hwedding.com/",
        kAddress:@"106台北市大安區安和路一段133號",
        kType:@(StoreTypeDress),
        kIsFavorites:@(NO)},
      ];
    NSArray <NSDictionary *> *buildInDataStoreTypePhotoArray =
    @[
      @{kStoreName:@"Hanwei Huang",
        kPhoneNumber:@"0972-335-749",
        kWebAddress:@"https://www.facebook.com/slashlovepa3",
        kAddress:@"",
        kType:@(StoreTypePhoto),
        kIsFavorites:@(NO)},
      @{kStoreName:@"Pure Bridal Makeup Studio",
        kPhoneNumber:@"02-2702-7685",
        kWebAddress:@"https://www.facebook.com/ashleystudio.kr",
        kAddress:@"fanta420@hotmail.com",
        kType:@(StoreTypePhoto),
        kIsFavorites:@(NO)},
      ];
    NSArray <NSDictionary *> *buildInDataStoreTypePrintArray =
    @[
      @{kStoreName:@"健豪印刷",
        kPhoneNumber:@"02-2760-3586",
        kWebAddress:@"http://www.gding.com.tw/",
        kAddress:@"105台北市松山區八德路四段78號",
        kType:@(StoreTypePrint),
        kIsFavorites:@(NO)},
      @{kStoreName:@"Andwedding",
        kPhoneNumber:@"04-23129192",
        kWebAddress:@"http://www.andwedding.com.tw/",
        kAddress:@"台中市西屯區四川路78巷5號",
        kType:@(StoreTypePrint),
        kIsFavorites:@(NO)},
      ];
    NSArray <NSDictionary *> *buildInDataStoreTypeRestaurantArray =
    @[
      @{kStoreName:@"儷宴會館",
        kPhoneNumber:@"02-2536-8899",
        kWebAddress:@"http://www.tgarden.com.tw/",
        kAddress:@"104台北市中山區林森北路413號",
        kType:@(StoreTypeRestaurant),
        kIsFavorites:@(NO)},
      @{kStoreName:@"一家餐廳",
        kPhoneNumber:@"08-932-9696",
        kWebAddress:@"http://tour.taitung.gov.tw/zh-tw/Dining/Shop/8/%E4%B8%80%E5%AE%B6%E9%A4%90%E5%BB%B3",
        kAddress:@"950台東縣台東市更生路321號",
        kType:@(StoreTypeRestaurant),
        kIsFavorites:@(NO)},
      ];
    NSArray <NSDictionary *> *buildInDataStoreTypeAllArray = [[[buildInDataStoreTypeDressArray arrayByAddingObjectsFromArray:buildInDataStoreTypePhotoArray] arrayByAddingObjectsFromArray:buildInDataStoreTypePrintArray] arrayByAddingObjectsFromArray:buildInDataStoreTypeRestaurantArray];
    [[NSUserDefaults standardUserDefaults] setObject:@(buildInDataStoreTypeAllArray.count) forKey:NUMBER_OF_BUILD_IN_DATA];
    
    buildInDataStoreTypeAllArray =[self addStoreIDForDataArray:buildInDataStoreTypeAllArray];
    
    if ([self shouldUpdateDBForBuildInData]) {
        [self updateToDBForBuildInDataArray:buildInDataStoreTypeAllArray];
    }
    else {
        [self initToDBForBuildInDataArray:buildInDataStoreTypeAllArray];
    }
}

- (BOOL)shouldUpdateDBForBuildInData
{
    NSNumber *numberOfBuildInData = [[NSUserDefaults standardUserDefaults] objectForKey:BUILD_IN_DATA_VERSION_KEY];
    NSComparisonResult result = [numberOfBuildInData compare:@(BUILD_IN_DATA_VERSION)];
    if (result == NSOrderedSame || result == NSOrderedDescending) {
        return NO;
    }
    else if (result == NSOrderedAscending) { // 遞增
        return YES;
    }
    return NO;
}

- (NSArray <NSDictionary *> *)addStoreIDForDataArray:(NSArray <NSDictionary* > *)dataArray
{
    NSMutableArray <NSDictionary *> *dataMutableArray = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
    NSInteger index = 0;
    for (NSDictionary *data in dataArray) {
        NSMutableDictionary *mutableData = [[NSMutableDictionary alloc] initWithDictionary:data];
        mutableData[kStoreID] = [self getKeyForBuildInStoreDataIndex:index];
        [dataMutableArray addObject:[[NSDictionary alloc] initWithDictionary:mutableData]];
        index ++;
    }
    return [[NSArray alloc] initWithArray:dataMutableArray];
}

- (void)initToDBForBuildInDataArray:(NSArray <NSDictionary* > *)dataArray
{
    for (NSInteger index = 0; index < [self numberOfBuildInData] ; index ++) {
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{dataArray[index][kStoreID] : dataArray[index]}];
    }
}

- (void)updateToDBForBuildInDataArray:(NSArray <NSDictionary* > *)dataArray
{
    [[NSUserDefaults standardUserDefaults] setObject:@(BUILD_IN_DATA_VERSION) forKey:BUILD_IN_DATA_VERSION_KEY];
    for (NSInteger index = 0; index < [self numberOfBuildInData] ; index ++) {
        [[NSUserDefaults standardUserDefaults] setObject:dataArray[index] forKey:dataArray[index][kStoreID]];
    }
}

- (NSArray <StoreData *> *)loadBuildInData
{
    NSMutableArray *buildInDatas = [[NSMutableArray alloc] init];
    for (NSInteger index = 0 ; index < [self numberOfBuildInData] ; index++) {
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyForBuildInStoreDataIndex:index]];
        if (dictionary == nil) {
            continue;
        }
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
        if (dictionary == nil) {
            continue;
        }
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

- (StoreData *)insertUserStoreDataWithStoreData:(NSDictionary <NSString*, NSString*> *)storeDataDictionary withType:(StoreType)type
{
    NSMutableDictionary *storeDataMutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:storeDataDictionary];
    storeDataMutableDictionary[kType] = @(type);
    storeDataMutableDictionary[kStoreID] = [self getKeyForUserStoreDataIndex:[self numberOfUserData]];
    storeDataMutableDictionary[kIsFavorites] = @(NO);
    StoreData *storeData = [[StoreData alloc] initWithDictionary:storeDataMutableDictionary];
    [self insertUserStoreDataToDBWithStoreData:storeData];
    return storeData;
}

- (void)insertUserStoreDataToDBWithStoreData:(StoreData *)storeData
{
    NSMutableDictionary *storeDataDictionary = [[NSMutableDictionary alloc] init];
    storeDataDictionary[kStoreName] = storeData.storeName;
    storeDataDictionary[kPhoneNumber] = storeData.phoneNumber;
    storeDataDictionary[kAddress] = storeData.address;
    storeDataDictionary[kWebAddress] = storeData.webAddress;
    storeDataDictionary[kType] = @(storeData.type);
    storeDataDictionary[kIsFavorites] = @(storeData.isFavorites);
    storeDataDictionary[kStoreID] = storeData.storeID;
    [[NSUserDefaults standardUserDefaults] setObject:storeDataDictionary forKey:storeData.storeID];
    [[NSUserDefaults standardUserDefaults] setObject:@([self numberOfUserData] + 1) forKey:NUMBER_OF_USER_DATA];
}

- (void)updateUserStoreDataWithStoreData:(StoreData *)storeData
{
    NSMutableDictionary *storeDataDictionary = [[NSMutableDictionary alloc] init];
    storeDataDictionary[kStoreName] = storeData.storeName;
    storeDataDictionary[kPhoneNumber] = storeData.phoneNumber;
    storeDataDictionary[kAddress] = storeData.address;
    storeDataDictionary[kWebAddress] = storeData.webAddress;
    storeDataDictionary[kType] = @(storeData.type);
    storeDataDictionary[kIsFavorites] = @(storeData.isFavorites);
    storeDataDictionary[kStoreID] = storeData.storeID;
    [[NSUserDefaults standardUserDefaults] setObject:storeDataDictionary forKey:storeData.storeID];
}

- (void)deleteUserStoreDataWithStoreData:(StoreData *)storeData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:storeData.storeID];
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
