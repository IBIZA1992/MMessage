//
//  DJChatView.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatView.h"

@implementation DJChatView

- (void)LoadChatView{
    
    _tableview = [[UITableView alloc] init];
    [_tableview setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self addSubview:_tableview];
      
}




@end
