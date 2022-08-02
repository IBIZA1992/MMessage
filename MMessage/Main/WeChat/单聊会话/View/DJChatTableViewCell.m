//
//  DJChatTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJChatTableViewCell.h"

@implementation DJChatTableViewCell


//重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
//        [self.contentView addSubview:({
//            _profile_image_url=[[UIImageView alloc] initWithFrame:CGRectZero];
//            _profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
//            _profile_image_url;
//        })];
//        //用户昵称
//        [self.contentView addSubview:({
//            _user_name=[[UILabel alloc] init];
//            _user_name;
//        })];
    }
    return self;
}





@end
