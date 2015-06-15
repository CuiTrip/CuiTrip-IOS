  
//
//  TPMessageListViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMessageListViewController.h"
#import "TPChatListViewController.h"
#import "TPMessageListModel.h" 
#import "TPMessageListViewDataSource.h"
#import "TPMessageListViewDelegate.h"

@interface TPMessageListViewController()

 
@property(nonatomic,strong)TPMessageListModel *messageListModel; 
@property(nonatomic,strong)TPMessageListViewDataSource *ds;
@property(nonatomic,strong)TPMessageListViewDelegate *dl;

@end

@implementation TPMessageListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPMessageListModel *)messageListModel
{
    if (!_messageListModel) {
        _messageListModel = [TPMessageListModel new];
        _messageListModel.key = @"__TPMessageListModel__";
    }
    return _messageListModel;
}


- (TPMessageListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPMessageListViewDataSource new];
   }
   return _ds;
}

 
- (TPMessageListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPMessageListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"消息"];
    [self.tabBarController hidesBottomBarWhenPushed];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = YES;
    self.tableView.tableFooterView = [TPUIKit emptyView];
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    //self.keyModel = self.model;
    
    //5,REQUIRED:register model to parent view controller
    //[self registerModel:self.keyModel];

    //6,Load Data
    //[self load];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //todo...
    TPChatListViewController* vc = [TPChatListViewController new];
    [self.navigationController pushViewController:vc animated:true];
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:... 

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
