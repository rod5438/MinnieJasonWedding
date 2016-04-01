//
//  PhoneBookTableView.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/1.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "PhoneBookTableView.h"
#import "PhoneBookTableViewCell.h"

@interface PhoneBookTableView() <PhoneBookTableViewCellDelegate>

@end

@implementation PhoneBookTableView 

- (void)onClickAddFavorites:(PhoneBookTableViewCell *)sender
{
    if ([self.delegate respondsToSelector:@selector(tableView:addFavoritesForRowAtIndexPath:)]) {
        NSIndexPath *indexPath = [self indexPathForCell:sender];
        [self.delegate tableView:self addFavoritesForRowAtIndexPath:indexPath];
    }
}

- (void)onClickRemoveFavorites:(PhoneBookTableViewCell *)sender
{
    if ([self.delegate respondsToSelector:@selector(tableView:removeFavoritesForRowAtIndexPath:)]) {
        NSIndexPath *indexPath = [self indexPathForCell:sender];
        [self.delegate tableView:self removeFavoritesForRowAtIndexPath:indexPath];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
