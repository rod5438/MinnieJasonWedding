//
//  CameraViewController.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/3.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "CameraViewController.h"
#import "MyImagePickerViewController.h"
#import "UIView+Toast.h"

@interface CameraViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyImagePickerViewController *picker = [[MyImagePickerViewController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *cameraImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = cameraImage;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

- (IBAction)sharePhoro:(id)sender
{
    // Show activity view controller
    NSMutableArray *items = [NSMutableArray arrayWithObject:self.imageView.image];
    [items addObject:@"Minnie & jason's wedding"];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    // Show
    typeof(self) __weak weakSelf = self;
    [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed) {
        if (completed) {
            [weakSelf.view makeToast:@"已分享" duration:1.0f position:CSToastPositionCenter];
        }
        else {
            [weakSelf.view makeToast:@"取消" duration:1.0f position:CSToastPositionCenter];
        }
    }];
    // iOS 8 - Set the Anchor Point for the popover
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending) {
        //self.activityViewController.popoverPresentationController.barButtonItem = _actionButton;
    }
    [self presentViewController:activityViewController animated:YES completion:nil];
    return;
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
