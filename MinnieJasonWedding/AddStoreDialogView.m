//
//  AddStoreDialogView.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/29.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "AddStoreDialogView.h"
#import "StoreData.h"

@implementation AddStoreDialogView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (IBAction)addStoreDialogCancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(addStoreDialogCancel)]) {
        [self.delegate addStoreDialogCancel];
    }
}

- (IBAction)addStoreDialogDone:(id)sender
{
    NSMutableDictionary *storeDataDictionary = [[NSMutableDictionary alloc] init];
    
    if (self.nameTextField.text && self.nameTextField.text.length > 0) {
        storeDataDictionary[kStoreName] = self.nameTextField.text;
    }
    if (self.phoneTextField.text && self.phoneTextField.text.length > 0) {
        storeDataDictionary[kPhoneNumber] = self.phoneTextField.text;
    }
    if (self.addressTextField.text && self.addressTextField.text.length > 0) {
        storeDataDictionary[kAddress] = self.addressTextField.text;
    }
    if (self.webAddressTextField.text && self.webAddressTextField.text.length > 0) {
        storeDataDictionary[kWebAddress] = self.webAddressTextField.text;
    }
    if ([self.delegate respondsToSelector:@selector(addStoreDialogDoneWithStoreData:)]) {
        [self.delegate addStoreDialogDoneWithStoreData:[[NSDictionary alloc] initWithDictionary:storeDataDictionary]];
    }
    if ([self.delegate respondsToSelector:@selector(addStoreDialogCancel)]) {
        [self.delegate addStoreDialogCancel];
    }
}

@end
