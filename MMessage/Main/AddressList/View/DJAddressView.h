//
//  DJAddressView.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import <UIKit/UIKit.h>
#import "DJAddressNavigationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJAddressView : UIView
@property(nonatomic, strong)DJAddressNavigationView *navView;



- (void)LoadAddressView;

@end

NS_ASSUME_NONNULL_END
