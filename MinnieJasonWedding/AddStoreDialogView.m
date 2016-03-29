//
//  AddStoreDialogView.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/29.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "AddStoreDialogView.h"

@implementation AddStoreDialogView

- (void)awakeFromNib
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (IBAction)addStoreDialogCancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addStoreDialogCancel)]) {
        [self.delegate addStoreDialogCancel];
    }
}

@end
