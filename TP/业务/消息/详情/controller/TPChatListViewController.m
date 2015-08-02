  
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
#import "TPSendChatMsgModel.h"
#import "TPPayViewController.h"
#import "TPChatListItem.h"
#import "TPReserveViewController.h"

@interface TPChatListViewController()<TPGrowingTextView>

@property(nonatomic,strong)TPSendChatMsgModel* sendTextModel;
@property(nonatomic,strong)TPChatListModel *chatListModel; 
@property(nonatomic,strong)TPChatListViewDataSource *ds;
@property(nonatomic,strong)TPChatListViewDelegate *dl;
@property(nonatomic,assign) BOOL canSendMsg;

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

- (TPSendChatMsgModel* )sendTextModel
{
    if (!_sendTextModel) {
        _sendTextModel = [TPSendChatMsgModel new];
    }
    return _sendTextModel;
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
    self.view.backgroundColor = [UIColor clearColor];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1,config your tableview
    self.view.backgroundColor = HEXCOLOR(0xeeeeee);
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    self.tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = NO;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = YES;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    self.keyModel = self.chatListModel;
    self.chatListModel.orderId = self.orderId;
    [self registerModel:self.keyModel];
    [self load];
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
//    [rightButton setImage:[UIImage imageNamed:@"search.png"]forState:UIControlStateNormal];
    [rightButton setTitle:@"查看旅程" forState:UIControlStateNormal];//设置button的title
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];//title字体大小
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
//    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         if (self.msgUserType == [TPUser type]) {
             TPTripDetailViewController* vc = [TPTripDetailViewController new];
             vc.oid = self.orderId;
             [self.navigationController pushViewController:vc animated:true];
         }
         else
         {
             TOAST(self, @"请切换用户身份后查看该旅程信息");
         }
         
     }];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    

    //单个手指双击屏幕事件注册
    UITapGestureRecognizer *oneFingerTwoTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)];
    // Set required taps and number of touches
    [oneFingerTwoTaps setNumberOfTapsRequired:2];
    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [[self view] addGestureRecognizer:oneFingerTwoTaps];
}

- (void)oneFingerTwoTaps
{
//    NSLog(@"Action: One finger, two taps");
    [TPGrowingTextView hideFromView:self.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TPChatListView"];
    self.tabBarController.tabBar.hidden = true;
    
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TPChatListView"];

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

    [self scrollToBottom:NO];
    [TPGrowingTextView showInView:self.view delegate:self];
    
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
//    kOrderReadyConfirm = 1,
//    kOrderReadyPay = 2,
//    kOrderReadyBegin = 3,
//    kOrderGoing = 4,
//    kOrderReadyComment = 5,
//    kOrderFinished = 6,
//    kOrderInvalid = 7,
//    kOrderRefunding = 8,
//    kOrderRefundFailed =9,
//    kOrderUnknown = -1

- (void)initCanSendMsg:(NSString *)orderStatus
{
    _orderStatus = orderStatus;
    self.canSendMsg = YES;
    switch ([_orderStatus integerValue]) {
        case kOrderFinished:
            self.canSendMsg = NO;
            break;
        case kOrderInvalid:
            self.canSendMsg = NO;
            break;
        default:
            break;
    }
}


//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 


- (void)textView:(UITextView* )view DidSendText:(NSString* )text
{
    __weak typeof(self)weakSelf = self;
    [self initCanSendMsg:(NSString *)self.orderStatus];
    
    if (!self.canSendMsg) {
        TOAST(weakSelf, @"订单已失效，如需联系，请重新预定旅程!");
        return;
    }
    self.sendTextModel.orderId = self.orderId;
    self.sendTextModel.send = [TPUser uid];
    self.sendTextModel.content = text;
    self.sendTextModel.receiver = self.receiverId;
    [self.sendTextModel loadWithCompletion:^(VZModel *model, NSError *error) {
       
        if (!error) {
            
            TPChatListItem* item = [TPChatListItem new];
            NSDictionary* dict = @{
                                   @"from":[TPUser uid],
                                   @"to":weakSelf.receiverId?:@"",
                                   @"headPic":[TPUser avatar]?:@"",
                                   @"content":text?:@"",
                                   @"gmtCreated":[TPUtils fullDateFormatString:[NSDate date]]
                                   };
            [item autoKVCBinding:dict];
            [weakSelf.ds addItem:item ForSection:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [weakSelf scrollToBottom:NO];
                [weakSelf vz_postToChannel:kChannelNewMessage withObject:nil Data:nil];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
        
    }];
    
}

- (void)textViewDidShow
{
    //todo
}
- (void)textViewDidHid
{
    self.tableView.vzOrigin = CGPointMake(0, 0);
}

- (void)scrollToBottom:(BOOL)animated
{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.tableView.vzWidth, CGFLOAT_MAX) animated:animated];
}

@end
 
