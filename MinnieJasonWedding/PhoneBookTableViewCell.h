//
//  PhoneBookTableViewCell.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreData.h"

typedef enum : NSUInteger {
    addFavorites,
    removeFavorites,
} FunctionButtonState;

@protocol PhoneBookTableViewCellDelegate <NSObject>

- (void)onClickAddFavorites:(id)sender;
- (void)onClickRemoveFavorites:(id)sender;

@end

@interface PhoneBookTableViewCell : UITableViewCell

@property (weak, nonatomic) id <PhoneBookTableViewCellDelegate> delegate;
@property (nonatomic, readonly) StoreData *storeData;
- (void)setStore:(StoreData *)storeData;
- (void)setState:(FunctionButtonState)state;

@end
