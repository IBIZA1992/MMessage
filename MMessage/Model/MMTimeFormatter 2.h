//
//  MMTimeFormatter.h
//  MMessage
//
//  Created by JiangNan on 2022/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTimeFormatter : NSObject

//+(NSString *)timeStampToNSString:(NSString *)timeStamp;
+(NSNumber *)NSStringToTimeStamp:(NSString *)dateStr;

@end

NS_ASSUME_NONNULL_END
