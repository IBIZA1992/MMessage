//
//  DJCreateGroupTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import "DJCreateGroupTableViewCell.h"

@implementation DJCreateGroupTableViewCell

//重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
        [self.contentView addSubview:({
            _profile_image_url=[[UIImageView alloc] initWithFrame:CGRectZero];
            _profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
            _profile_image_url;
        })];
        //用户昵称
        [self.contentView addSubview:({
            _user_name=[[UILabel alloc] init];
            _user_name;
        })];
        //开关
        [self.contentView addSubview:({
            _Switch = [[UISwitch alloc] init];
            _Switch;
        })];
    }
    return self;
}

- (void)LoadCreateGroupTableViewCellWithItem:(DJListItem *)item {
    _item = item;
    [self SetFrame:item];
    [self SetData:item];
    
    [_Switch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
}

- (void) switchChange:(UISwitch*)sw {
    if(sw.on == YES) {
        NSLog(@"开关切换为开");
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:_item.username forKey:@"username"];
        NSNotification *note = [NSNotification notificationWithName:@"add" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:note];
  
    } else{
        NSLog(@"开关切换为关");
        NSDictionary *dic = [NSDictionary dictionaryWithObject:_item.username forKey:@"username"];
        NSNotification *note = [NSNotification notificationWithName:@"cancel" object:self userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:note];
    }
}



- (void)SetFrame:(DJListItem *)item {
    
    _profile_image_url.frame = CGRectMake(10, 10, 40, 40);
    _user_name.frame = CGRectMake(60, 20, 100, 20);
    _user_name.textAlignment = NSTextAlignmentLeft;
    _Switch.frame = CGRectMake(150, 10, 50, 50);
    
}

- (void)SetData:(DJListItem *)item {
    _single = [DJSingleton sharedManager];
    /**头像*/
    if(item.avater) {
        NSArray *array=[[NSArray alloc] initWithObjects:item.username,nil];
        [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
            JMSGUser *user = resultObject[0];
            [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
                self->_profile_image_url.image = [UIImage imageWithData:data];
            }];
        }];
    }
    else
        _profile_image_url.image = [UIImage imageNamed:@"head"];
    
    /**昵称*/
    if(item.username) {
        _user_name.text = item.username;
    }
    else
        _user_name.text = @"路人甲";
    
}







@end
