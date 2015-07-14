  
//
//  TPDiscoveryListViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPDiscoveryListViewController.h"
#import "TPDiscoveryListModel.h" 
#import "TPDiscoveryListViewDataSource.h"
#import "TPDiscoveryListViewDelegate.h"
#import "TPDiscoveryDetailListViewController.h"
#import "TPDiscoveryListItem.h"

@interface TPDiscoveryListViewController()

 
@property(nonatomic,strong)TPDiscoveryListModel *discoveryListModel; 
@property(nonatomic,strong)TPDiscoveryListViewDataSource *ds;
@property(nonatomic,strong)TPDiscoveryListViewDelegate *dl;

@end

@implementation TPDiscoveryListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPDiscoveryListModel *)discoveryListModel
{
    if (!_discoveryListModel) {
        _discoveryListModel = [TPDiscoveryListModel new];
        _discoveryListModel.key = @"__TPDiscoveryListModel__";
    }
    return _discoveryListModel;
}


- (TPDiscoveryListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPDiscoveryListViewDataSource new];
   }
   return _ds;
}

 
- (TPDiscoveryListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPDiscoveryListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    
    [self setTitle:@"热门推荐"];
    self.view.backgroundColor = [TPTheme bgColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = true;
    self.needPullRefresh = true;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    [self.tableView reloadData];
    

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.keyModel = self.discoveryListModel;
    
    //5,REQUIRED:register model to parent view controller
    [self registerModel:self.keyModel];

    //6,Load Data
    [self load];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TPDiscoveryListView"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [MobClick endLogPageView:@"TPDiscoveryListView"];
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

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController

- (void)showError:(NSError *)error withModel:(VZModel *)model
{
    [super showError:error withModel:model];
    self.tableView.tableFooterView = [TPUIKit emptyView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    TPDiscoveryListItem* item = (TPDiscoveryListItem* )[self.ds itemForCellAtIndexPath:indexPath];
    TPDiscoveryDetailListViewController* vc= [ TPDiscoveryDetailListViewController new ];
    vc.sid = item.sid;
    [self.navigationController pushViewController:vc animated:YES];
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:... 

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
