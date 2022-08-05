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
    _single = [DJSingleton sharedManager];
    /**头像*/
    if(item.avater){
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
    
//    JMSGUser *user = [JMSGUser myInfo];
//    if(item.avater){
//        if(_single.imagePath1 != nil){
//            UIImage *image = [UIImage imageWithContentsOfFile:_single.imagePath1];
//            _profile_image_url.image = image;
//        }
//        if(_single.imagePath1 == nil){
//            NSArray *array=[[NSArray alloc] initWithObjects:user.username,nil];
//            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
//                JMSGUser *user = resultObject[0];
//                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
//                    self->_profile_image_url.image = [UIImage imageWithData:data];
//                    NSString *path_document = NSHomeDirectory();
//                    self->_single.imagePath1 = [path_document stringByAppendingString:@"/Documents/pic1.png"];
//                    [UIImagePNGRepresentation(self->_profile_image_url.image) writeToFile:self->_single.imagePath1 atomically:YES];
//                    NSLog(@"");
//                }];
//            }];
//        }
//    }
//    else{
//        _profile_image_url.image = [UIImage imageNamed:@"head"];
//    }
//
    
    
    
    
    
    
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
