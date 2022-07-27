//
//  ViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/26.
//

#import "ViewController.h"
#import <JMessage/JMessage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JMSGUser registerWithUsername:@"IBIZA" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
            NSLog(@"");
        [JMSGUser loginWithUsername:@"IBIZA" password:@"123456" completionHandler:^(id resultObject, NSError *error) {
            NSLog(@"");
        }];
    }];
//
    [JMSGUser logout:^(id resultObject, NSError *error) {
            NSLog(@"");
    }];
////    
    
    
}
 

@end
