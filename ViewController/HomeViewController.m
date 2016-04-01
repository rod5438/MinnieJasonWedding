//
//  HomeViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/1.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "HomeViewController.h"
#import "PhoneBookTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StoreTypeDress"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypeDress;
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypePhoto"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypePhoto;
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypePrint"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypePrint;
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypeRestaurant"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypeRestaurant;
        return;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
