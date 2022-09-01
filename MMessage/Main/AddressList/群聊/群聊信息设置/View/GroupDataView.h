//
//  GroupDataView.h
//  MMessage
//
//  Created by 邓杰 on 2022/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupDataView : UIView

@property(nonatomic, strong)UIButton *btngroupImage; //群头像
@property(nonatomic ,strong)UILabel *groupName; //群昵称


@property(nonatomic, strong)UITableView *tableView;

- (void)loadGroupDataView;

@end

NS_ASSUME_NONNULL_END
