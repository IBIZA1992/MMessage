//
//  DJSingleton.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/1.
//

#import "DJSingleton.h"

@implementation DJSingleton

+ (DJSingleton *)sharedManager {
  static dispatch_once_t onceToken;
  static DJSingleton *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager=[[DJSingleton alloc] init];
  });
  return sharedManager;
}


@end
