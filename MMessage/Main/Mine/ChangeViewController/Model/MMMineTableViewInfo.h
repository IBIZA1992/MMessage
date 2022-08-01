//
//  MMMineTableViewInfo.h
//  MMessage
//
//  Created by JiangNan on 2022/7/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// cell的类别
typedef NS_ENUM(NSUInteger, MMInfoType) {
    MMInfoTypeHeadPicture             = 0,  // 头像
    MMInfoTypeNickname                = 1,  // 昵称
//    MMInfoTypeUsername                = 2,  // 用户名
    MMInfoTypeBirthday                = 2,  // 生日
    MMInfoTypeGender                  = 3,  // 性别
    MMInfoTypeAddress                 = 4,  // 地址
    MMInfoTypeSignature               = 5   // 签名
};

/// 用于储存单个用户个人信息
@interface MMMineTableViewInfoItem : NSObject
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) MMInfoType infoType;
@property (nonatomic, copy, readwrite) NSString *text;
NS_ASSUME_NONNULL_END
@end

/// 用于驱动tableView布局cell
@interface MMMineTableViewInfo : NSArray
NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
@end


