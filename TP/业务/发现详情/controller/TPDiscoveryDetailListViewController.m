  
//
//  TPDiscoveryDetailListViewController.m
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryDetailListViewController.h"
 
#import "TPDiscoveryDetailListModel.h" 
#import "TPDiscoveryDetailListViewDataSource.h"
#import "TPDiscoveryDetailListViewDelegate.h"

@interface TPDiscoveryDetailListViewController()

@property(nonatomic,strong)UIImageView* parallexView;
@property(nonatomic,strong)TPDiscoveryDetailListModel *discoveryDetailListModel; 
@property(nonatomic,strong)TPDiscoveryDetailListViewDataSource *ds;
@property(nonatomic,strong)TPDiscoveryDetailListViewDelegate *dl;

@end

@implementation TPDiscoveryDetailListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPDiscoveryDetailListModel *)discoveryDetailListModel
{
    if (!_discoveryDetailListModel) {
        _discoveryDetailListModel = [TPDiscoveryDetailListModel new];
        _discoveryDetailListModel.key = @"__TPDiscoveryDetailListModel__";
    }
    return _discoveryDetailListModel;
}


- (TPDiscoveryDetailListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPDiscoveryDetailListViewDataSource new];
   }
   return _ds;
}

 
- (TPDiscoveryDetailListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPDiscoveryDetailListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    self.navigationController.navigationBarHidden = true;
    self.tabBarController.tabBar.hidden  =  true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    
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
    
    
    //header view
    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.vzWidth, 135)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    
    //footer view
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.tableView.vzWidth, 44)];
    btn.backgroundColor = [TPTheme themeColor];
    [btn setTitle:@"联系预定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [btn addTarget:self action:@selector(onPreserveClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = btn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:... 

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
