//
//  DJAddFriendViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/7/28.
//

#import "DJAddFriendViewController.h"
#import "DJAddFriendView.h"
#import "DJUserDataViewController.h"
#import "JMessage/JMessage.h"
#import "DJSingleton.h"
#import "DJListItem.h"

@interface DJAddFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)DJAddFriendView *addView;
@property(nonatomic, strong)DJUserDataViewController *userdataVC;
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJListItem *item;

@end

@implementation DJAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _addView = [[DJAddFriendView alloc] init];
    _addView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [_addView LoadAddFriendView];
    [self.view addSubview:_addView];
    
    /**代理*/
    _addView.tableView.delegate = self;
    _addView.tableView.dataSource = self;
   // _addView.tableView.tableHeaderView = _addView.btnsearch;
    _addView.tableView.tableHeaderView = _addView.searchtext;

    
    /**搜索*/
    [_addView.btnsearch addTarget:self action:@selector(search)  forControlEvents:UIControlEventTouchUpInside];
    /**添加好友*/
    [_addView.navView.btnleft addTarget:self action:@selector(back)  forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationBar.barTintColor = WECHAT_TABBAR_BACKGROUND_GREY;

    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"好友",@"群组"]];
    segControl.tintColor = [UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1];
    [segControl setSelectedSegmentIndex:0];
    self.navigationItem.titleView = segControl;
    
    
    
}

- (void)search{
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = NO;
  
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    if(indexPath.row==0){
        cell.textLabel.text=@"雷达添加朋友";
        cell.detailTextLabel.text=@"面对面加好友";
        cell.imageView.image=[UIImage imageNamed:@"group"];
    }
    if(indexPath.row==1){
        cell.textLabel.text=@"手机联系人";
        cell.detailTextLabel.text=@"添加通讯录中的朋友";
        cell.imageView.image=[UIImage imageNamed:@"group"];
    }
    if(indexPath.row==2){
        cell.textLabel.text=@"扫一扫";
        cell.detailTextLabel.text=@"扫描二维码名片";
        cell.imageView.image=[UIImage imageNamed:@"group"];
    }
    if(indexPath.row==3){
        cell.textLabel.text=@"搜索";
    }
    return cell;

}

//点击进入tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 3){
        
        _single = [DJSingleton sharedManager];
        
        //NSArray *array = _addView.searchtext.text;
        NSArray *array=[[NSArray alloc] initWithObjects:_addView.searchtext.text,nil];


        
        [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
            self->_item = [[DJListItem alloc] init];
            NSLog(@"");
            [self->_item LoadUserDataModel:resultObject[0]];
            self->_single.userdata = self->_item;
            
            
            NSLog(@"");
            self->_userdataVC = [[DJUserDataViewController alloc] init];
            [self.navigationController pushViewController:self->_userdataVC animated:YES];
        }];
        
        
 
        
        
    }
    
    
    
}




@end
