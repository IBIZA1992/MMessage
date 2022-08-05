//
//  MMMineChangeViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/7/29.
//

#import "MMScreen.h"
#import "MMColor.h"
#import "MMMineChangeViewController.h"
#import "JMessage/JMessage.h"
#import "MMMineTableViewInfo.h"
#import "MMMineTableViewCell.h"
#import "MMChangeDetailViewController.h"

@interface MMMineChangeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *navigationView;
@property (nonatomic, strong, readwrite) JMSGUser *user;
@property (nonatomic, strong, readwrite) NSArray<MMMineTableViewInfoItem *> *infoArray;
@property (nonatomic, strong, readwrite) NSTimer *timer;

@end

@implementation MMMineChangeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;

        self.navigationItem.title = @"个人信息";
        
    };
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoArray = [[MMMineTableViewInfo alloc] init];
    
    self.user = [JMSGUser myInfo];
    [self.view addSubview:({
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   STATUS_NAVIGATION_BAR_HEIGHT,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = WECHAT_BACKGROUND_GREY;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView;
    })];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.infoArray[indexPath.row].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MMChangeDetailViewController *changeDetailViewController = [[MMChangeDetailViewController alloc] initWithInfoItem:self.infoArray[indexPath.row]];
    [self.navigationController pushViewController:changeDetailViewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    NSString *identifier = ((WBWeiBoItem *)self.dataArray[indexPath.row]).idstr;
//    WBWeiBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
//    if (!cell) {
//        cell = [[WBWeiBoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
//        __weak typeof(self) wself = self;
//        [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row] clickWebBlock:^(NSURL * _Nonnull URL) {
//            __strong typeof(wself) strongSelf = wself;
//            WBWebViewController *webViewController = [[WBWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
//            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(weiBoDetailView:pushViewController:)]) {
//                [strongSelf.delegate weiBoDetailView:self pushViewController:webViewController];
//            }
//        }];
//    } else {
//        __weak typeof(self) wself = self;
//        [cell ReLayoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row] clickWebBlock:^(NSURL * _Nonnull URL) {
//                    __strong typeof(wself) strongSelf = wself;
//                    WBWebViewController *webViewController = [[WBWebViewController alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
//                    if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(weiBoDetailView:pushViewController:)]) {
//                        [strongSelf.delegate weiBoDetailView:self pushViewController:webViewController];
//                    }
//        }];
//    }
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // 使用名称作唯一标志，加载一次即可
#warning 由于复用回收机制，所以加载图片和之前不一样，一定要注意，这个在写完cell后再写
    MMMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[MMMineTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
        [cell layoutWithInfoItem:self.infoArray[indexPath.row]];
    } else {
        [cell reLayoutWithInfoItem:self.infoArray[indexPath.row]];
    }
    
    return cell;
}


@end
