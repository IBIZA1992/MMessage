//
//  DJGroupView.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJGroupView : UIView

@property(nonatomic, strong) UIButton *btnsearch;
@property(nonatomic, strong) UITableView *tableView;


- (void)LoadGroupView;


@end

NS_ASSUME_NONNULL_END
