//
//  DJToolNavigationBar.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import "DJToolNavigationBar.h"

@implementation DJToolNavigationBar

- (void)LoadNavigationView{
    
    self.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(SCREEN_WIDTH/2-100, STATUS_NAVIGATION_BAR_HEIGHT-35, 200, 20);
   // _title.text = @"通讯录";
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:18]; // 设置字体大小并为粗体
    _title.textAlignment = NSTextAlignmentCenter; // 设置字体的显示位置居中
    [self addSubview:_title];

    _btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnright setFrame:CGRectMake(SCREEN_WIDTH-40, STATUS_NAVIGATION_BAR_HEIGHT-32, 20, 20)];
    //[_btnright setBackgroundImage:[UIImage imageNamed:@"addfriend"] forState:UIControlStateNormal];
    [self addSubview:_btnright];
    
    _btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnleft setFrame:CGRectMake(40, STATUS_NAVIGATION_BAR_HEIGHT-32, 20, 20)];
    //[_btnright setBackgroundImage:[UIImage imageNamed:@"addfriend"] forState:UIControlStateNormal];
    [self addSubview:_btnleft];
    
    
    
    
    
}

@end
