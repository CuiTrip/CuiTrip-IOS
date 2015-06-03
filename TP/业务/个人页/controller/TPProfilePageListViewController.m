  
//
//  TPProfilePageListViewController.m
//  TP
//
//  Created by moxin on 2015-06-04 00:05:25 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPProfilePageListViewController.h"
 
#import "TPProfilePageListModel.h" 
#import "TPProfilePageListViewDataSource.h"
#import "TPProfilePageListViewDelegate.h"

@interface TPProfilePageListViewController()

 
@property(nonatomic,strong)TPProfilePageListModel *profilePageListModel; 
@property(nonatomic,strong)TPProfilePageListViewDataSource *ds;
@property(nonatomic,strong)TPProfilePageListViewDelegate *dl;

@end

@implementation TPProfilePageListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPProfilePageListModel *)profilePageListModel
{
    if (!_profilePageListModel) {
        _profilePageListModel = [TPProfilePageListModel new];
        _profilePageListModel.key = @"__TPProfilePageListModel__";
    }
    return _profilePageListModel;
}


- (TPProfilePageListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPProfilePageListViewDataSource new];
   }
   return _ds;
}

 
- (TPProfilePageListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPProfilePageListViewDelegate new];
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
 
