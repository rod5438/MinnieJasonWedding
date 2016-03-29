//
//  PhoneBookTableViewCell.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhoneBookTableViewCell.h"

@interface PhoneBookTableViewCell()

@property (nonatomic) StoreData *storeData;
@property IBOutlet UILabel *storeNameLabel;
@property IBOutlet UILabel *phoneNumberLabel;
@property IBOutlet UILabel *adderessLabel;
@property IBOutlet UILabel *webAddressLabel;

@end

@implementation PhoneBookTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setStore:(StoreData *)storeData
{
    _storeData = storeData;
    _storeNameLabel.text = storeData.storeName;
    _phoneNumberLabel.text = storeData.phoneNumber;
    _adderessLabel.text = storeData.address;
    _webAddressLabel.text = storeData.webAddress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
