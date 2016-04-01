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
@property (nonatomic)  FunctionButtonState state;

@end

@implementation PhoneBookTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setState:(FunctionButtonState)state
{
    _state = state;
    switch (state) {
        case addFavorites:
            [self.functionButton setTitle:@"加入最愛" forState:UIControlStateNormal];
            [self.functionButton setTitle:@"加入最愛" forState:UIControlStateSelected];
            [self.functionButton setTitle:@"加入最愛" forState:UIControlStateHighlighted];
            break;
        case removeFavorites:
        default:
            [self.functionButton setTitle:@"移除最愛" forState:UIControlStateNormal];
            [self.functionButton setTitle:@"移除最愛" forState:UIControlStateSelected];
            [self.functionButton setTitle:@"移除最愛" forState:UIControlStateHighlighted];
            break;
    }
    return;
}

- (void)setStoreDataDictionary:(NSDictionary<NSString *,NSString *> *)storeDataDictionary
{
    _storeNameLabel.text = storeDataDictionary[@"storeName"];
    _phoneNumberLabel.text = storeDataDictionary[@"phoneNumber"];
    _adderessLabel.text = storeDataDictionary[@"address"];
    _webAddressLabel.text = storeDataDictionary[@"webAddress"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickFunctionButton:(id)sender
{
    switch (self.state) {
        case addFavorites:
            if ([self.delegate respondsToSelector:@selector(onClickAddFavorites:)]) {
                [self.delegate onClickAddFavorites:self];
            }
            break;
        case removeFavorites:
        default:
            if ([self.delegate respondsToSelector:@selector(onClickRemoveFavorites:)]) {
                [self.delegate onClickRemoveFavorites:self];
            }
            break;
    }
}

@end
