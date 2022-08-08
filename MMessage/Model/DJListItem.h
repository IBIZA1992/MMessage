//
//  DJListItem.h
//  MMessage
//
//  Created by 邓杰 on 2022/7/29.
//

#import <Foundation/Foundation.h>
# import "JMessage/JMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJListItem : NSObject

///用户信息
@property(nonatomic, assign, readonly)BOOL isFriend; //是否为好友
@property(nonatomic, assign, readonly)BOOL isDisturb;  //是否开启勿打扰
@property(nonatomic, assign, readonly)BOOL isInBlacklist;  //是否加入黑名单
@property(nonatomic, strong)NSString *uid; //用户id
@property(nonatomic, strong)NSString *username; //用户名
@property(nonatomic, copy)NSString *nickname; //用户昵称
@property(nonatomic, strong)NSString *avater; //用户头像
@property(nonatomic, strong)NSString *birthday; //用户生日
@property(nonatomic, assign, readwrite) JMSGUserGender gender;  // 性别
@property(nonatomic, strong, readwrite) NSString *signature; //签名
@property(nonatomic, strong)NSString *region; //用户地区
@property(nonatomic, strong)NSString *address; //用户住址
@property(nonatomic, strong)NSString *password; //用户密码
@property(nonatomic, strong)NSString *noteName; //备注名
@property(nonatomic, strong)NSString *noteText; //备注信息
@property(nonatomic, strong)NSString *appKey; //app密钥
@property(nonatomic, strong)NSData *avatarData;

@property(nonatomic, strong)NSString *imageStr;


//聊天内容模型化
@property(nonatomic, strong)NSString *text;
//@property(nonatomic, strong)




- (void)LoadUserDataModel:(JMSGUser *)user;
@end

NS_ASSUME_NONNULL_END
