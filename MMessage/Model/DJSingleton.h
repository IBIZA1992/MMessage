//
//  DJSingleton.h
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import <Foundation/Foundation.h>
#import "DJListItem.h"
#import "JMessage/JMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJSingleton : NSObject
///我的用户信息
@property(nonatomic, strong)DJListItem *userdata;
///请求添加好友列表
@property(nonatomic, strong)NSMutableArray *addrequestArray;
///user
@property(nonatomic, strong)JMSGUser *user;
///消息内容列表
@property(nonatomic, strong)NSMutableArray *messageArray;
///消息列表
@property(nonatomic, strong)NSMutableArray *messagelistArray;
///我的头像地址
@property(nonatomic, strong)NSString *imagePath1;
///聊天对方头像地址
@property(nonatomic, strong)NSString *imagePath2;
///聊天图片地址
@property(nonatomic, strong)NSMutableArray *imagePathArray;
///聊天类型 1:为单聊    2:为群聊
@property(nonatomic )int messageType;
///群聊id
@property(nonatomic, strong)NSString *groupID;


///单例方法，只创建一个对象
+ (DJSingleton *)sharedManager;

@end

NS_ASSUME_NONNULL_END
