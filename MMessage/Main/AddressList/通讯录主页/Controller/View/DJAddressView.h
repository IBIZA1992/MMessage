//
//  DJAddressView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "DJToolNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAddressView : UIView
@property(nonatomic, strong)DJToolNavigationBar *navView; //工具Bar
@property(nonatomic, strong)UIButton *btnsearch; //搜索按钮
@property(nonatomic, strong)UITableView *BasicTableView; //tableview


///加载Address的View
- (void)LoadAddressView;

@end

NS_ASSUME_NONNULL_END
