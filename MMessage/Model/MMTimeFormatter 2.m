//
//  MMTimeFormatter.m
//  MMessage
//
//  Created by JiangNan on 2022/8/2.
//

#import "MMTimeFormatter.h"

@implementation MMTimeFormatter

//+(NSString *)timeStampToNSString:(NSString *)timeStamp
//{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateStr = [formatter stringFromDate:date];
//    return dateStr;
//}

+(NSNumber *)NSStringToTimeStamp:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:dateStr];
    NSNumber *timeStamp = @(date.timeIntervalSince1970);
    return timeStamp;
}

@end
