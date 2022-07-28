//
//  DJAddressNavigationView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddressNavigationView.h"

@implementation DJAddressNavigationView

- (void)LoadNavigationView{
    
    self.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(SCREEN_WIDTH/2-30, STATUS_NAVIGATION_BAR_HEIGHT-35, 60, 20);
    _title.text = @"通讯录";
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:15]; // 设置字体大小并为粗体
    _title.textAlignment = NSTextAlignmentCenter; // 设置字体的显示位置居中
    [self addSubview:_title];

    _btnAddFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnAddFriend setFrame:CGRectMake(SCREEN_WIDTH-40, STATUS_NAVIGATION_BAR_HEIGHT-40, 20, 20)];
    [_btnAddFriend setBackgroundImage:[UIImage imageNamed:@"addfriend"] forState:UIControlStateNormal];
    [self addSubview:_btnAddFriend];
    
    
    
}






@end
