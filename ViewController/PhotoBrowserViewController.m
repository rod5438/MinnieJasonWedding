//
//  PhotoBrowserViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/21.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController () <MWPhotoBrowserDelegate>

@property (nonatomic) NSArray *allImageNameArray;

@end

@implementation PhotoBrowserViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString * documentsPath = [resourcePath stringByAppendingPathComponent:@"PhotoBrowser"];
    NSError * error;
    self.allImageNameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self reloadData];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.allImageNameArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    NSString *imageName = self.allImageNameArray[index];
    UIImage *image = [UIImage imageNamed:imageName];
    return [[MWPhoto alloc] initWithImage:image];
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
