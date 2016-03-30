//
//  AddStoreDialogView.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/29.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddStoreDialogViewDelegate <NSObject>

- (void)addStoreDialogCancel;
- (void)addStoreDialogDoneWithStoreData:(NSDictionary <NSString*, NSString*> *)storeDataDictionary;

@end

@interface AddStoreDialogView : UIView

@property (weak, nonatomic) IBOutlet id<AddStoreDialogViewDelegate> delegate;
@property (nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic) IBOutlet UITextField *addressTextField;
@property (nonatomic) IBOutlet UITextField *webAddressTextField;

@end
