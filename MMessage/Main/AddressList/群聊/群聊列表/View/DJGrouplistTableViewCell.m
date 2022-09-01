//
//  DJGrouplistTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/10.
//

#import "DJGrouplistTableViewCell.h"

@implementation DJGrouplistTableViewCell

//重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
            _group_name=[[UILabel alloc] init];
            _group_name;
        })];
    }
    return self;
}


- (void)LoadGroupListTableViewCellWithItem:(NSNumber *)groupID{
    
    [JMSGGroup groupInfoWithGroupId:[NSNumberFormatter localizedStringFromNumber:groupID numberStyle:NSNumberFormatterNoStyle] completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"");
        [self SetFrame:resultObject];
        [self SetData:resultObject];
    }];
    
    
    
  
}

- (void)SetFrame:(JMSGGroup *)group{
    _profile_image_url.frame = CGRectMake(10, 10, 40, 40);
    _group_name.frame = CGRectMake(60, 20, 100, 20);
    _group_name.textAlignment = NSTextAlignmentLeft;
    
}

- (void)SetData:(JMSGGroup *)group{
    _profile_image_url.image = [UIImage imageNamed:@"head"];
    _group_name.text = [group.owner stringByAppendingString:@"的群组"];
}



@end
