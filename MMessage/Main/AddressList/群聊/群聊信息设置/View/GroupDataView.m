//
//  GroupDataView.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/1.
//

#import "GroupDataView.h"

@implementation GroupDataView


- (void)loadGroupDataView{
    
    _btngroupImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btngroupImage setFrame:CGRectMake(20, 60, 70, 70)];
    [_btngroupImage setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self addSubview:_btngroupImage];
    
    _groupName = [[UILabel alloc] init];
    [_groupName setFrame:CGRectMake(110, 80, 200, 40)];
    _groupName.textColor = [UIColor blackColor];
    _groupName.font = [UIFont systemFontOfSize:20];
    _groupName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_groupName];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setFrame:CGRectMake(0, 150, 390, 844-150)];
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setBackgroundView:nil];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_tableView];
    
}




@end
