//
//  MMMoremessageViewController.m
//  MMessage
//
//  Created by JiangNan on 2022/8/8.
//

#import "MMScreen.h"
#import "MMMoremessageViewController.h"
#import "MMColor.h"
#import "MMMoremessageTableViewCell.h"

@interface MMMoremessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation MMMoremessageViewController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = WECHAT_BACKGROUND_GREY;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   STATUS_NAVIGATION_BAR_HEIGHT,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - STATUS_NAVIGATION_BAR_HEIGHT)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = WECHAT_BACKGROUND_GREY;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.allowsSelection = NO;
        self.tableView;
    })];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ( UI(100) * 0.618 );
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMMoremessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[MMMoremessageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
        [cell layoutWithRow:indexPath.row];
    } else {
        [cell layoutWithRow:indexPath.row];
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
