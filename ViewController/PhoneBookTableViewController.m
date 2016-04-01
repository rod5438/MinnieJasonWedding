//
//  PhoneBookTableViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhoneBookTableViewController.h"
#import "PhoneBookTableView.h"
#import "PhoneBookTableViewCell.h"
#import "DataBaseManager.h"
#import "AddStoreDialogView.h"
#import "UIView+Toast.h"

#define kHeaderCellHeight 30
#define kFavoritesSection 0
#define kUserDataSection 1
#define kBuildInSection 2

@interface PhoneBookTableViewController () <PhoneBookTableViewDelegate>

@property NSArray <StoreData *> *userData;
@property NSArray <StoreData *> *buildInData;
@property NSArray <StoreData *> *favoritesData;

@property IBOutlet AddStoreDialogView *addStoreDialogView;

@end

@implementation PhoneBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buildInData = [[DataBaseManager sharedInstance] loadBuildInDataWithType:self.type];
    self.userData = [[DataBaseManager sharedInstance] loadUserDataWithType:self.type];
    self.favoritesData = [self getFavoritesDataFromAllData:[self.userData arrayByAddingObjectsFromArray:self.buildInData]];
}

- (NSArray <StoreData *> *)getFavoritesDataFromAllData:(NSArray <StoreData *> *)allData
{
    NSMutableArray *favoritesData = [[NSMutableArray alloc] init];
    for (StoreData *storedata in allData) {
        if (storedata.isFavorites) {
            [favoritesData addObject:storedata];
        }
    }
    return [NSArray arrayWithArray:favoritesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kFavoritesSection) { // 最愛
        return self.favoritesData.count;
    }
    else if (section == kUserDataSection) {  // 使用者新增
        return self.userData.count;
    }
    else if (section == kBuildInSection) { // 內建
        return self.buildInData.count;
    }
    return 0;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneBookTableViewCell *cell = (PhoneBookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == kFavoritesSection) {
        [cell setStoreDataDictionary:self.favoritesData[indexPath.item].storeDataDictionary];
        [cell setState:removeFavorites];
    }
    else if (indexPath.section == kUserDataSection) {
        [cell setStoreDataDictionary:self.userData[indexPath.item].storeDataDictionary];
        [cell setState:addFavorites];
    }
    else if (indexPath.section == kBuildInSection) {
        [cell setStoreDataDictionary:self.buildInData[indexPath.item].storeDataDictionary];
        [cell setState:addFavorites];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHeaderCellHeight)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [textLabel setTextColor:[UIColor colorWithRed:221.0/255.0 green:60.0/255.0 blue:113.0/255.0 alpha:1.0]];
    [textLabel setContentMode:UIViewContentModeBottom];
    if (section == kFavoritesSection) {
        [textLabel setText:@"我的最愛"];
    }
    else if (section == kUserDataSection) {
        [textLabel setText:@"使用者新增"];
    }
    else if (section == kBuildInSection) {
        [textLabel setText:@"目錄"];
    }
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHeaderCellHeight)];
    [header setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    [header addSubview:textLabel];
    return header;
}

#pragma mark - PhoneBookTableViewDelegate

- (void)tableView:( UITableView * _Nonnull )tableView addFavoritesForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    StoreData *storeData = [self getStoreDataForIndexPath:indexPath];
    [self addFavoritesToDBWith:storeData];
    [self addFavoritesToModelWith:storeData];
    [self addFavoritesToViewWithIndexPath:[NSIndexPath indexPathForItem:self.favoritesData.count - 1 inSection:kFavoritesSection]];
}

- (void)tableView:( UITableView * _Nonnull )tableView removeFavoritesForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    StoreData *storeData = [self getStoreDataForIndexPath:indexPath];
    [self removeFavoritesToDBWithStoreData:storeData];
    [self removeFavoritesToModelWithStoreData:storeData];
    [self removeFavoritesToViewWithIndexPath:indexPath];
}

- (StoreData * _Nullable)getStoreDataForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kFavoritesSection) {
        return self.favoritesData[indexPath.row];
    }
    if (indexPath.section == kUserDataSection) {
        return self.userData[indexPath.row];
    }
    if (indexPath.section == kBuildInSection) {
        return self.buildInData[indexPath.row];
    }
    return nil;
}

- (NSArray <NSIndexPath *> * _Nonnull)getIndexPathsForStoreData:(StoreData *)storeData
{
    NSMutableArray <NSIndexPath *> *indexPathsArray = [[NSMutableArray alloc] init];
    NSInteger index;
    index = [self.favoritesData indexOfObject:storeData];
    if (index != NSNotFound) {
        [indexPathsArray addObject:[NSIndexPath indexPathForItem:index inSection:kFavoritesSection]];
    }
    index = [self.userData indexOfObject:storeData];
    if (index != NSNotFound) {
        [indexPathsArray addObject:[NSIndexPath indexPathForItem:index inSection:kUserDataSection]];
    }
    index = [self.buildInData indexOfObject:storeData];
    if (index != NSNotFound) {
        [indexPathsArray addObject:[NSIndexPath indexPathForItem:index inSection:kBuildInSection]];
    }
    return [NSArray arrayWithArray:indexPathsArray];
}

- (IBAction)addUserStore:(id)sender
{
    [self.view addSubview:self.addStoreDialogView];
}

- (void)addStoreDialogCancel
{
    [self.addStoreDialogView removeFromSuperview];
}

- (void)addStoreDialogDoneWithStoreData:(NSDictionary <NSString*, NSString*> *)storeDataDictionary;
{
    if ([self canAddStoreWithStoreDataDictionary:storeDataDictionary]) {
        StoreData *storeData = [self addNewStoreDataToDBWithStoreData:storeDataDictionary];
        [self addNewStoreDataModelWithStoreData:storeData];
        [self addNewStoreDataToViewWithIndexPath:[NSIndexPath indexPathForRow:self.userData.count - 1 inSection:1]];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.userData.count - 1 inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (BOOL)canAddStoreWithStoreDataDictionary:(NSDictionary <NSString*, NSString*> *)storeDataDictionary;
{
    if (storeDataDictionary[kStoreName] == nil || ((NSString *)storeDataDictionary[kStoreName]).length <= 0) {
        [self.view makeToast:@"您至少要輸入店家名稱" duration:1.0f position:CSToastPositionCenter];
        return NO;
    }
    return YES;
}

- (StoreData *)addNewStoreDataToDBWithStoreData:(NSDictionary *)storeData // data method
{
    StoreData *data = [[DataBaseManager sharedInstance] insertUserStoreDataWithStoreData:storeData withType:self.type];
    return data;
}

- (void)addNewStoreDataModelWithStoreData:(StoreData *)storeData // model method
{
    self.userData = [self.userData arrayByAddingObject:storeData];
}

- (void)addNewStoreDataToViewWithIndexPath:(NSIndexPath *)indexPath // view method
{
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)addFavoritesToDBWith:(StoreData *)storeData
{
    storeData.isFavorites = YES;
    [[DataBaseManager sharedInstance] updateUserStoreDataWithStoreData:storeData];
}

- (void)addFavoritesToModelWith:(StoreData *)storeData
{
    if (![self.favoritesData containsObject:storeData]) {
        self.favoritesData = [self.favoritesData arrayByAddingObject:storeData];
    }
}

- (void)addFavoritesToViewWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        return;
    }
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)removeFavoritesToDBWithStoreData:(StoreData *)storeData
{
    storeData.isFavorites = NO;
    [[DataBaseManager sharedInstance] updateUserStoreDataWithStoreData:storeData];
}

- (void)removeFavoritesToModelWithStoreData:(StoreData *)storeData
{
    if (![self.favoritesData containsObject:storeData]) {
        return;
    }
    NSMutableArray *favoritesMutableAData = [[NSMutableArray alloc] initWithArray:self.favoritesData];
    [favoritesMutableAData removeObject:storeData];
    self.favoritesData = [NSArray arrayWithArray:favoritesMutableAData];
    return;
}

- (void)removeFavoritesToViewWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == kBuildInSection) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == kFavoritesSection) {
            StoreData *storeData = [self getStoreDataForIndexPath:indexPath];
            [self removeFavoritesToDBWithStoreData:storeData];
            [self removeFavoritesToModelWithStoreData:storeData];
            [self removeFavoritesToViewWithIndexPath:indexPath];
        }
        else if (indexPath.section == kUserDataSection) {
            StoreData *storeData = [self getStoreDataForIndexPath:indexPath];
            NSArray <NSIndexPath *> *indexPathsArray = [self getIndexPathsForStoreData:storeData];
            [self deleteStoreDataToDBWithStoreData:storeData];
            [self deleteStoreDataToModelWithStoreData:storeData];
            [self deleteStoreDataToViewWithIndexPathsArray:indexPathsArray];
        }
    }
}

- (void)deleteStoreDataToDBWithStoreData:(StoreData *)storeData // data method
{
    [[DataBaseManager sharedInstance] deleteUserStoreDataWithStoreData:storeData];
}

- (void)deleteStoreDataToModelWithStoreData:(StoreData *)storeData // model method
{
    NSMutableArray *userDataMutableArray;
    userDataMutableArray = [NSMutableArray arrayWithArray:self.userData];
    [userDataMutableArray removeObject:storeData];
    self.userData = [NSArray arrayWithArray:userDataMutableArray];
    userDataMutableArray = [NSMutableArray arrayWithArray:self.favoritesData];
    [userDataMutableArray removeObject:storeData];
    self.favoritesData = [NSArray arrayWithArray:userDataMutableArray];
    return;
}

- (void)deleteStoreDataToViewWithIndexPath:(NSIndexPath *)indexPath // view method
{
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)deleteStoreDataToViewWithIndexPathsArray:(NSArray <NSIndexPath *> *)indexPathsArray
{
    if (indexPathsArray == nil || indexPathsArray.count <= 1) {
        return;
    }
    [self.tableView deleteRowsAtIndexPaths:indexPathsArray withRowAnimation:UITableViewRowAnimationTop];
}

@end
