//
//  MyImagePickerViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/3.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "MyImagePickerViewController.h"
#import "PreviewView.h"

@interface MyImagePickerViewController ()

@property (nonatomic) UIImageView *minnieAndJasonImageView;

@end

@implementation MyImagePickerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minnieAndJasonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minnieAndJason.png"]];
        self.minnieAndJasonImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.minnieAndJasonImageView.frame = CGRectMake(0, 200, 120, 240);
    [self.view addSubview:self.minnieAndJasonImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:self.minnieAndJasonImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
