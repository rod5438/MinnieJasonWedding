//
//  PhoneBookTableView.h
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/4/1.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneBookTableViewDelegate <UITableViewDelegate>

- (void)tableView:( UITableView * _Nonnull )tableView addFavoritesForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:( UITableView * _Nonnull )tableView removeFavoritesForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end

@interface PhoneBookTableView : UITableView

@property (nonatomic, weak, nullable) IBOutlet id <PhoneBookTableViewDelegate> delegate;

@end
