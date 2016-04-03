//
//  PhoneBookTableViewCell.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhoneBookTableViewCell.h"

@interface PhoneBookTableViewCell()

@property IBOutlet UILabel *storeNameLabel;
@property IBOutlet UILabel *phoneNumberLabel;
@property IBOutlet UILabel *adderessLabel;
@property IBOutlet UILabel *webAddressLabel;
@property IBOutlet UIButton *functionButton;

@end

@implementation PhoneBookTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setIsFavorites:(BOOL)isFavorites
{
    _isFavorites = isFavorites;
    UIImage *image = isFavorites ? [UIImage imageNamed:@"heartPress.png"] : [UIImage imageNamed:@"heart.png"];
    [self.functionButton setImage:image forState:UIControlStateNormal];
    [self.functionButton setImage:image forState:UIControlStateSelected];
    [self.functionButton setImage:image forState:UIControlStateHighlighted];
}

- (void)setStoreDataDictionary:(NSDictionary<NSString *,NSString *> *)storeDataDictionary
{
    _storeNameLabel.text = storeDataDictionary[@"storeName"];
    _phoneNumberLabel.text = storeDataDictionary[@"phoneNumber"];
    _adderessLabel.text = storeDataDictionary[@"address"];
    _webAddressLabel.text = storeDataDictionary[@"webAddress"];
    self.isFavorites = [storeDataDictionary[@"isFavorites"] boolValue];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickFunctionButton:(id)sender
{
    if (self.isFavorites) {
        if ([self.delegate respondsToSelector:@selector(onClickRemoveFavorites:)]) {
            [self.delegate onClickRemoveFavorites:self];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(onClickAddFavorites:)]) {
            [self.delegate onClickAddFavorites:self];
        }
    }
}

@end
