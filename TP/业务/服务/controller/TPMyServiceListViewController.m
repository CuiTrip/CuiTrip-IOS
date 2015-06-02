  
//
//  TPMyServiceListViewController.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPMyServiceListViewController.h"
 
#import "TPMyServiceListModel.h" 
#import "TPMyServiceListViewDataSource.h"
#import "TPMyServiceListViewDelegate.h"

@interface TPMyServiceListViewController()

 
@property(nonatomic,strong)TPMyServiceListModel *myServiceListModel; 
@property(nonatomic,strong)TPMyServiceListViewDataSource *ds;
@property(nonatomic,strong)TPMyServiceListViewDelegate *dl;

@end

@implementation TPMyServiceListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPMyServiceListModel *)myServiceListModel
{
    if (!_myServiceListModel) {
        _myServiceListModel = [TPMyServiceListModel new];
        _myServiceListModel.key = @"__TPMyServiceListModel__";
    }
    return _myServiceListModel;
}


- (TPMyServiceListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPMyServiceListViewDataSource new];
   }
   return _ds;
}

 
- (TPMyServiceListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPMyServiceListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = YES;
    
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
 
