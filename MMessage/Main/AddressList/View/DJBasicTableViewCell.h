//
//  DJBasicTableViewCell.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJBasicTableViewCell : UITableViewCell

@property(nonatomic)CGFloat BasicTableViewCellHeight;

//搜索栏
@property(nonatomic, strong)UIButton *btnsearch;






- (void)LoadBasicTableViewCell:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
