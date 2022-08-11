//
//  DJCreateGroupBarView.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "MMColor.h"
NS_ASSUME_NONNULL_BEGIN

@interface DJCreateGroupBarView : UIView

@property(nonatomic, strong)UIButton *btncreate;
@property(nonatomic, strong)UILabel *label;

- (void)LoadGroupBarView;

@end

NS_ASSUME_NONNULL_END
