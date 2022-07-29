//
//  DJToolNavigationBar.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import <UIKit/UIKit.h>
#import "MMScreen.h"
#import "MMColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJToolNavigationBar : UIView

@property(nonatomic, strong)UILabel *title;
@property(nonatomic, strong)UIButton *btnright;
@property(nonatomic, strong)UIButton *btnleft;


- (void)LoadNavigationView;


@end

NS_ASSUME_NONNULL_END
