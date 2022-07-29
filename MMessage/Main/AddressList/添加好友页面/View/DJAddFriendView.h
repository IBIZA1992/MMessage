//
//  DJAddFriendView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import <UIKit/UIKit.h>
#import "DJToolNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAddFriendView : UIView

@property(nonatomic, strong)DJToolNavigationBar *navView;
@property(nonatomic, strong)UIButton *btnsearch;
@property(nonatomic, strong)UITableView *tableView;

- (void)LoadAddFriendView;

@end

NS_ASSUME_NONNULL_END
