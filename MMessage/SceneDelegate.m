//
//  SceneDelegate.m
//  MMessage
//
//  Created by JiangNan on 2022/7/26.
//

#import "MMColor.h"
#import "SceneDelegate.h"
#import "MMTabBarController.h"
#import "DJSingleton.h"

@interface SceneDelegate ()
@property(nonatomic, strong)UINavigationController *HomeNavVC;
@property(nonatomic, strong)UINavigationController *LoginNavVC;
@property(nonatomic, strong)DJSingleton *single;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    /**创建窗口*/
    UIWindowScene *windowscene=(UIWindowScene*)scene;
    self.window=[[UIWindow alloc] initWithWindowScene:windowscene];
    self.window.frame=windowscene.coordinateSpace.bounds;
    
    //登陆注册窗口
    DJLoginViewController *loginVC = [[DJLoginViewController alloc] init];
    _LoginNavVC=[[UINavigationController alloc] initWithRootViewController:loginVC];
    
    //主页窗口
    MMTabBarController *tabBarController = [[MMTabBarController alloc] init];
    _HomeNavVC = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    _HomeNavVC.navigationBar.tintColor = [UIColor blackColor];
    UINavigationBarAppearance *barAppearance = [UINavigationBarAppearance new];
    barAppearance.backgroundColor = WECHAT_BACKGROUND_GREY;
    [[UINavigationBar appearance] setStandardAppearance:barAppearance];
    
    BOOL LoginYesOrNo = NO;

    if(!LoginYesOrNo) {
        self.window.rootViewController =_LoginNavVC;
        [self.window makeKeyAndVisible];
    };

    if(LoginYesOrNo) {
        self.window.rootViewController =_HomeNavVC;
        [self.window makeKeyAndVisible];
    }
   
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(login) name:@"login" object:nil];
 
    [notiCenter addObserver:self selector:@selector(outlogin) name:@"outlogin" object:nil];
 
    _single = [DJSingleton sharedManager];
    _single.addrequestArray = [[NSMutableArray alloc] initWithCapacity:10];
    _single.messagelistArray = @[].mutableCopy;
    _single.imagePathArray = @[].mutableCopy;
    
    
    
    //清除一天以前的图片缓存
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary* defaults = [defs dictionaryRepresentation];
    NSLog(@"");
    for(id key in defaults) {
        if([self isPureInt:key]){
            NSInteger time = [self handleDate:key];
            if(time > 60*60*24){
                [defs removeObjectForKey:key];
            }
        }
    }

    
}

- (void)login {
    [self.window.rootViewController removeFromParentViewController];
    self.window.rootViewController =_HomeNavVC;
    [self.window makeKeyAndVisible];
}

- (void)outlogin {
    [self.window.rootViewController removeFromParentViewController];
    self.window.rootViewController =_LoginNavVC;
    [self.window makeKeyAndVisible];
}


///判断字符串是否为整形
- (BOOL)isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

///时间戳格式化
- (NSInteger )handleDate:(NSString *)time_Stamp{

    NSMutableString *str;
    NSDate *date = [NSDate date];
    NSTimeInterval cur_time = date.timeIntervalSince1970;

    NSTimeInterval result = cur_time - [time_Stamp doubleValue]/1000.0;
    
    NSInteger time = round(result);


    return time;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
