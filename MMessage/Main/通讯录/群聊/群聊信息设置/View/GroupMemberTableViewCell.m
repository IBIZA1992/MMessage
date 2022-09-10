//
//  GroupMemberTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/9/1.
//

#import "GroupMemberTableViewCell.h"

@implementation GroupMemberTableViewCell


- (void)loadGroupMemberCell:(JMSGUser *)User {
    [self SetData:User];
    [self SetFrame:User];
}


- (void)SetData:(JMSGUser *)User{
    [User thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
        self.image.image = [UIImage imageWithData:data];
    }];
    
    _name.text = User.username;
}

- (void)SetFrame:(JMSGUser *)User {
    [_image setFrame:CGRectMake(10, 10, 40, 40)];
    [_name setFrame:CGRectMake(60, 20, 200, 20)];
    _name.textAlignment = NSTextAlignmentLeft;
}



///重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self.contentView addSubview:({
            _image = [[UIImageView alloc] initWithFrame:CGRectZero];
            _image.contentMode=UIViewContentModeScaleAspectFit;
            _image;
        })];
        [self.contentView addSubview:({
            _name = [[UILabel alloc] init];
            _name;
        })];
    }
    return self;
}


@end
