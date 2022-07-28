//
//  DJAddressView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddressView.h"

@implementation DJAddressView

- (void)LoadAddressView{
    
    _navView = [[DJAddressNavigationView alloc] init];
    _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
    [_navView LoadNavigationView];
    [self addSubview:_navView];
    
    
    
    
    
}






@end
