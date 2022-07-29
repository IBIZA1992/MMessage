//
//  DJAddFriendView.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import "DJAddFriendView.h"

@implementation DJAddFriendView

- (void)LoadAddFriendView{
    
    _navView = [[DJToolNavigationBar alloc] init];
    _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
    [_navView LoadNavigationView];
    [_navView.btnleft setBackgroundImage:[UIImage imageNamed:@"backR"] forState:UIControlStateNormal];
    _navView.title.text = @"添加朋友｜群组";
    [self addSubview:_navView];
    

    _btnsearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnsearch setFrame:CGRectMake(20, STATUS_NAVIGATION_BAR_HEIGHT+10, SCREEN_WIDTH-40, 40)];
    [_btnsearch setBackgroundImage:[UIImage imageNamed:@"截屏2022-07-28 21.42.12"] forState:UIControlStateNormal];
    [self addSubview:_btnsearch];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setFrame:CGRectMake(0, STATUS_NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT)];
    [self addSubview:_tableView];
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
