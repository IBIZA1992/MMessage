//
//  DJBasicTableViewCell.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJBasicTableViewCell.h"

@implementation DJBasicTableViewCell


- (void)LoadBasicTableViewCellWithItem:(DJListItem *)item {
    [self SetData:item];
    [self SetFrame:item];
}

///加载数据
- (void)SetData:(DJListItem *)item {
    _single = [DJSingleton sharedManager];
    //头像
    if([[NSUserDefaults standardUserDefaults] objectForKey:item.avater]) {/**如果本地有图片*/
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:item.avater];
        _profile_image_url.image = [UIImage imageWithData:imageData];
    }
    else {
        if(item.avater){/**判断是否有头像*/
            NSArray *array = [[NSArray alloc] initWithObjects:item.username,nil]; /**获得对方账号的userdata存入array中*/
            [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) { /**通过对方的userdata获取对方的信息*/
                JMSGUser *user = resultObject[0]; /**返回对象即为对方的user*/
                [user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) { /**从网络请求头像数据*/
                    self.profile_image_url.image = [UIImage imageWithData:data]; /**更新UI数据*/
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{/**在子线程中将头像数据存入本地磁盘*/
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:item.avater];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    });
                }];
            }];
        }
        else{
            if(item.imageStr) {
                NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:item.imageStr options:0];
                _profile_image_url.image = [UIImage imageWithData:decodedImageData];
            }
            else
                _profile_image_url.image = [UIImage imageNamed:@"head"];
        }
    }
 
   
    /**昵称*/
    if(item.username) {
        _user_name.text = item.username;
    }
    else
        _user_name.text = @"路人甲";
}

///加载Frame
- (void)SetFrame:(DJListItem *)item {
    _profile_image_url.frame = CGRectMake(10, 10, 40, 40);
    _user_name.frame = CGRectMake(60, 20, 100, 20);
    _user_name.textAlignment = NSTextAlignmentLeft;
}



///重写初始化方法 创造控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //用户头像
        [self.contentView addSubview:({
            _profile_image_url = [[UIImageView alloc] initWithFrame:CGRectZero];
            _profile_image_url.contentMode=UIViewContentModeScaleAspectFit;
            _profile_image_url;
        })];
        //用户昵称
        [self.contentView addSubview:({
            _user_name = [[UILabel alloc] init];
            _user_name;
        })];
    }
    return self;
}






@end
