//
//  PhoneBookTableViewCell.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/27.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    addFavorites,
    removeFavorites,
} FunctionButtonState;

@protocol PhoneBookTableViewCellDelegate <NSObject>

- (void)onClickAddFavorites:(id)sender;
- (void)onClickRemoveFavorites:(id)sender;

@end

@interface PhoneBookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet id <PhoneBookTableViewCellDelegate> delegate;
- (void)setStoreDataDictionary:(NSDictionary <NSString *, NSString *> *)storeDataDictionary;
- (void)setState:(FunctionButtonState)state;

@end
