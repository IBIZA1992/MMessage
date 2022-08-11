//
//  DJSearchAddFriendViewController.m
//  MMessage
//
//  Created by 邓杰 on 2022/8/2.
//

#import "DJSearchAddFriendViewController.h"
#import "DJSearchAddFriendView.h"
#import "DJSingleton.h"
#import "DJListItem.h"
#import "JMessage/JMessage.h"
#import "DJBasicTableViewCell.h"
#import "DJUserDataViewController.h"


@interface DJSearchAddFriendViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property(nonatomic, strong)DJSearchAddFriendView *searchView;
@property(nonatomic, strong)UISearchBar *searchBar;
@property(nonatomic, strong)DJSingleton *single;
@property(nonatomic, strong)DJListItem *item;
@property(nonatomic )int type;
@property(nonatomic, strong)DJBasicTableViewCell *cell;
@property(nonatomic, strong)DJUserDataViewController *userdataVC;

@end

@implementation DJSearchAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _searchView = [[DJSearchAddFriendView alloc] init];
    [_searchView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_searchView LoadSearchAddFriendView];
    [self.view addSubview:_searchView];
    
    _searchView.tableview.delegate = self;
    _searchView.tableview.dataSource = self;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 65,35)];
    UIColor *color = self.navigationController.navigationBar.backgroundColor;
    [titleView setBackgroundColor:color];
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.delegate =self;
    _searchBar.frame =CGRectMake(0,0,CGRectGetWidth(titleView.frame),35);
    _searchBar.backgroundColor = color;
    _searchBar.layer.cornerRadius =18;
    _searchBar.layer.masksToBounds =YES;
    _searchBar.showsCancelButton = YES;
    _searchBar.showsSearchResultsButton = YES;

    _searchBar.placeholder = @"搜索";
    [titleView addSubview:_searchBar];
    self.navigationItem.titleView = titleView;


}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _type = 0;
}


//当输入内容改变
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(text){
        searchBar.placeholder = nil;
    }
    if([text  isEqual: @""]){
        searchBar.placeholder = @"搜索";
    }

    return YES;
}



//点击取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _single = [DJSingleton sharedManager];
    NSArray *array=[[NSArray alloc] initWithObjects:searchBar.text,nil];
    [JMSGUser userInfoArrayWithUsernameArray:array completionHandler:^(id resultObject, NSError *error) {
        if(!error){
            self->_type = 1;
            self->_item = [[DJListItem alloc] init];
            [self->_item LoadUserDataModel:resultObject[0]];
            self->_single.userdata = self->_item;
            [self->_searchView.tableview reloadData];
            NSLog(@"");
        }
        if(error){
            self->_type = 2;
            [self->_searchView.tableview reloadData];
        }
    }];
    
    
    
    
}




//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_type == 0){
        return 0;
    }
    else{
        return 1;
    }
}

//设置宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


//内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_type == 1){
        static NSString *CellIdentifier = @"Cell";
        _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (_cell == nil) {
            _cell = [[DJBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        _single = [DJSingleton sharedManager];
        [_cell LoadBasicTableViewCellWithItem:_single.userdata];
        return _cell;
    }
    
    else{
        
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
            cell.textLabel.text=@"没有搜索到相关结果";
        return cell;
    }
}


//点击进入tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_type == 1){
        _userdataVC = [[DJUserDataViewController alloc] init];
        [self.navigationController pushViewController:_userdataVC animated:YES];
    }
}





@end
