//
//  DJBasicTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJBasicTableViewCell.h"

@implementation DJBasicTableViewCell

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
            _user_name=[[UILabel alloc] init];
            _user_name;
        })];
    }
    return self;
}

- (void)LoadBasicTableViewCellWithItem:(DJListItem *)item{
    [self SetData:item];
    [self SetFrame:item];
    NSLog(@"");
}

- (void)SetData:(DJListItem *)item{
    /**头像*/
    if(item.imageStr){
        NSData  *decodedImageData = [[NSData alloc] initWithBase64Encoding:item.imageStr];
        UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
        _profile_image_url.image = decodedImage;
        NSLog(@"");
    }
    else
        _profile_image_url.image = [UIImage imageNamed:@"head"];
    NSLog(@"");
    /**昵称*/
    if(item.username){
        _user_name.text = item.username;
    }
    else
        _user_name.text = @"路人甲";
}
    
- (void)SetFrame:(DJListItem *)item{
    _profile_image_url.frame = CGRectMake(10, 10, 40, 40);
    _user_name.frame = CGRectMake(60, 20, 100, 20);
    _user_name.textAlignment = NSTextAlignmentLeft;
}










@end
