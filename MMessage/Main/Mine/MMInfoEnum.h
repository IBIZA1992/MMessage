//
//  MMInfoEnum.h
//  MMessage
//
//  Created by JiangNan on 2022/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MMInfoType) {
    MMInfoTypeHeadPicture             = 0,  // 头像
    MMInfoTypeNickname                = 1,  // 昵称
    MMInfoTypeUsername                = 2,  // 用户名
    MMInfoTypeBirthday                = 3,  // 生日
    MMInfoTypeGender                  = 4,  // 性别
    MMInfoTypeAddress                 = 5,  // 地址
    MMInfoTypeSignature               = 6   // 签名
    
};

@interface MMInfoEnum : NSObject

@end

NS_ASSUME_NONNULL_END
