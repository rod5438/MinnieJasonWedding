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

@end

@interface AddStoreDialogView : UIView

@property (weak, nonatomic) IBOutlet id<AddStoreDialogViewDelegate> delegate;

@end
