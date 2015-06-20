  
//
//  TPChatListViewController.m
//  TP
//
//  Created by moxin on 2015-06-10 15:33:15 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPChatListViewController.h"
#import "TPChatListModel.h" 
#import "TPChatListViewDataSource.h"
#import "TPChatListViewDelegate.h"
#import "TPGrowingTextView.h"
#import "TPTripDetailViewController.h"

@interface TPChatListHeaderView : UIView

@property(nonatomic,assign)TPUserType type;
@property(nonatomic,strong)UILabel* dateLabel;
@property(nonatomic,strong)UIButton* actionBtn;
@property(nonatomic,strong)void(^callback)(void);

@end

@implementation TPChatListHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [TPTheme blackColor];
        self.dateLabel= [TPUIKit label:[UIColor whiteColor] Font:ft(18)];
        self.dateLabel.vzOrigin = CGPointMake(11, (frame.size.height-18)/2);
        self.dateLabel.vzSize = CGSizeMake(frame.size.width-100, 18);
        [self addSubview:self.dateLabel];
        
        self.actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-70, (frame.size.height-30)/2, 60, 30)];
        self.actionBtn.layer.cornerRadius = 8.0f;
        self.actionBtn.layer.masksToBounds = true;
        self.actionBtn.titleLabel.font = ft(14);
        [self.actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.actionBtn addTarget:self action:@selector(onAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionBtn];
        
    }
    return self;
}

- (void)setType:(TPUserType)type
{
    _type = type;
    
    if (type == kCustomer) {
        
        self.actionBtn.backgroundColor = HEXCOLOR(0xff6600);
        [self.actionBtn setTitle:@"付款" forState:UIControlStateNormal];
    }
    else
    {
        self.actionBtn.backgroundColor = HEXCOLOR(0x7ed321);
        [self.actionBtn setTitle:@"确认" forState:UIControlStateNormal];
        
    }
}

- (void)onAction:(id)sender
{
    if (self.callback) {
        self.callback();
    }
}

@end

@interface TPChatListViewController()

@property(nonatomic,strong)TPChatListHeaderView* headerView;
@property(nonatomic,strong)TPChatListModel *chatListModel; 
@property(nonatomic,strong)TPChatListViewDataSource *ds;
@property(nonatomic,strong)TPChatListViewDelegate *dl;

@end

@implementation TPChatListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPChatListModel *)chatListModel
{
    if (!_chatListModel) {
        _chatListModel = [TPChatListModel new];
        _chatListModel.key = @"__TPChatListModel__";
    }
    return _chatListModel;
}


- (TPChatListViewDataSource *)ds{

  if (!_ds) {
      _ds = [TPChatListViewDataSource new];
   }
   return _ds;
}

 
- (TPChatListViewDelegate *)dl{

  if (!_dl) {
      _dl = [TPChatListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"消息详情"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView = [[TPChatListHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 50)];
    self.headerView.dateLabel.text = @"";
    self.headerView.type = [TPUser type];
    
    __weak typeof(self) weakSelf = self;
    self.headerView.callback = ^(){
        
        if ([TPUser type] == kCustomer) {
            //去支付
            UIViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppay"];
            [weakSelf.navigationController pushViewController:vc animated:true];
        }
        else
        {
            //去旅行详情
            TPTripDetailViewController* vc = [[UIStoryboard storyboardWithName:@"TPTripDetailViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tptripdetail"];
            vc.status = kWillBegin;
            [weakSelf.navigationController pushViewController:vc animated:true];
            
        }
    };
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    self.tableView.tableHeaderView = self.headerView;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    
    [self.tableView reloadData];

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.keyModel = self.chatListModel;
    
    [TPGrowingTextView showInView:self.view];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
    
    [self load];
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

- (void)showModel:(VZModel *)model
{
    [super showModel:model];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self.chatListModel.serviceDate doubleValue]];
    NSString* dateString = [TPUtils fullDateFormatString:date];
    self.headerView.dateLabel.text = [NSString stringWithFormat:@"%@ / %@人",dateString,self.chatListModel.peopleNum];
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //todo...
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:... 

}


////////////////////////////////////////////////////////////
#pragma mark - scrollview delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    [TPGrowingTextView hideFromView:self.view];
    
}


//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
