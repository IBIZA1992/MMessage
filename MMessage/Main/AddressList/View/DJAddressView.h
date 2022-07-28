//
//  DJAddressView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "DJAddressNavigationView.h"
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAddressView : UIView
@property(nonatomic, strong)DJAddressNavigationView *navView;
//搜索栏
@property(nonatomic, strong)UIButton *btnsearch;
//最底层容器
@property(nonatomic, strong)UITableView *BasicTableView;




@property(nonatomic, strong)UIScrollView *BackscrollView;


- (void)LoadAddressView;

@end

NS_ASSUME_NONNULL_END
