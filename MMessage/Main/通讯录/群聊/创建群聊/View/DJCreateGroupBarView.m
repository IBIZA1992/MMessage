//
//  DJCreateGroupBarView.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import "DJCreateGroupBarView.h"

@implementation DJCreateGroupBarView

- (void)LoadGroupBarView {
    
    self.backgroundColor = WECHAT_TABBAR_BACKGROUND_GREY;

    _btncreate = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btncreate setFrame:CGRectMake(SCREEN_WIDTH/2-45, 10, 60, 30)];
    [_btncreate setBackgroundColor:[UIColor blueColor]];
    [_btncreate setTitle:@"创建" forState:UIControlStateNormal];
    [_btncreate setTintColor:[UIColor blackColor]];
    [_btncreate setEnabled:NO];
    [self addSubview:_btncreate];
    
    _label = [[UILabel alloc] init];
    [_label setFrame:CGRectMake(SCREEN_WIDTH/2+20, 10, 100, 30)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.text = @"(0)";

    [self addSubview:_label];
    
    
    
}





@end
