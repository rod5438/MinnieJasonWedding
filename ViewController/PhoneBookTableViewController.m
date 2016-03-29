//
//  PhoneBookTableViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhoneBookTableViewController.h"
#import "PhoneBookTableViewCell.h"
#import "DataBaseManager.h"
#import "AddStoreDialogView.h"

#define kHeaderCellHeight 30
@interface PhoneBookTableViewController ()

@property NSArray <StoreData *> *userData;
@property NSArray <StoreData *> *buildInData;
@property NSArray <StoreData *> *favoritesData;

@property IBOutlet AddStoreDialogView *addStoreDialogView;

@end

@implementation PhoneBookTableViewController

- (void)awakeFromNib
{
    self.type = StoreTypeDress;
}

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
    if (section == 0) { // 最愛
        return self.favoritesData.count;
    }
    else if (section == 1) {  // 使用者新增
        return self.userData.count;
    }
    else if (section == 2) { // 內建
        return self.buildInData.count;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneBookTableViewCell *cell = (PhoneBookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [cell setStore:self.favoritesData[indexPath.item]];
    }
    else if (indexPath.section == 1) {
        [cell setStore:self.userData[indexPath.item]];
    }
    else if (indexPath.section == 2) {
        [cell setStore:self.buildInData[indexPath.item]];
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
    if (section == 0) {
        [textLabel setText:@"我的最愛"];
    }
    else if (section == 1) {
        [textLabel setText:@"使用者新增"];
    }
    else if (section == 2) {
        [textLabel setText:@"目錄"];
    }
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kHeaderCellHeight)];
    [header setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    [header addSubview:textLabel];
    return header;
}

- (IBAction)addUserStore:(id)sender
{
    [self.view addSubview:self.addStoreDialogView];
}

- (void)addStoreDialogCancel
{
    [self.addStoreDialogView removeFromSuperview];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
