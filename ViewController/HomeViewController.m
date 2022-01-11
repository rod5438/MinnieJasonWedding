//
//  HomeViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/1.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "HomeViewController.h"
#import "PhoneBookTableViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (@available(iOS 14, *)) {
      [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        NSLog(@"Status: %lu", (unsigned long)status);
      }];
    }
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
        dst.title = @"婚紗公司";
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypePhoto"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypePhoto;
        dst.title = @"攝影公司";
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypePrint"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypePrint;
        dst.title = @"喜帖印刷";
        return;
    }
    if ([segue.identifier isEqualToString:@"StoreTypeRestaurant"]) {
        PhoneBookTableViewController *dst = (PhoneBookTableViewController *)segue.destinationViewController;
        dst.type = StoreTypeRestaurant;
        dst.title = @"喜宴餐廳";
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
