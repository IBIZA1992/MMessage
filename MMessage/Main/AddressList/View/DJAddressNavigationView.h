//
//  DJAddressNavigationView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "MMColor.h"
#import "MMScreen.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAddressNavigationView : UIView
@property(nonatomic, strong)UILabel *title;
@property(nonatomic, strong)UIButton *btnAddFriend;

- (void)LoadNavigationView;

@end

NS_ASSUME_NONNULL_END
