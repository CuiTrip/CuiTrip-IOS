  
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

@interface TPChatListHeaderView : UIView

@property(nonatomic,strong)NSString* orderStatus;
@property(nonatomic,strong)NSString* insiderId;
@property(nonatomic,strong)UILabel* dateLabel;
@property(nonatomic,strong)UIButton* actionBtn;
@property(nonatomic,strong)void(^callback)(NSString* orderStatus);

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
        self.actionBtn.hidden = true;
        [self.actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.actionBtn addTarget:self action:@selector(onAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionBtn];
        
    }
    return self;
}


- (void)setOrderStatus:(NSString *)orderStatus
{
    _orderStatus = orderStatus;
    
    if ([orderStatus integerValue] == 1)
    {
        if ([TPUser type] == kCustomer) {
            
            self.actionBtn.backgroundColor = HEXCOLOR(0xff6600);
            [self.actionBtn setTitle:@"修改" forState:UIControlStateNormal];
            self.actionBtn.hidden = false;
        }
        else
        {
            self.actionBtn.backgroundColor = HEXCOLOR(0x7ed321);
            
            if ([[TPUser uid] isEqualToString:self.insiderId]) {
                
                [self.actionBtn setTitle:@"确认" forState:UIControlStateNormal];
                self.actionBtn.hidden = false;
            }
            else
            {
                self.actionBtn.hidden = true;
            }
        }
    }
    else if ([orderStatus integerValue] == 2)
    {
        if ([TPUser type] == kCustomer) {
            
            self.actionBtn.backgroundColor = HEXCOLOR(0xff6600);
            [self.actionBtn setTitle:@"付款" forState:UIControlStateNormal];
        }
        else
            self.actionBtn.hidden = true;
    }
    else
    {
        self.actionBtn.hidden = true;
    }
}

- (void)onAction:(id)sender
{
    if (self.callback) {
        self.callback(self.orderStatus);
    }
}

@end

@interface TPChatListViewController()<TPGrowingTextView>

@property(nonatomic,strong)TPChatListHeaderView* headerView;
@property(nonatomic,strong)TPSendChatMsgModel* sendTextModel;
@property(nonatomic,strong)TPChatListModel *chatListModel; 
@property(nonatomic,strong)TPChatListViewDataSource *ds;
@property(nonatomic,strong)TPChatListViewDelegate *dl;
@property(nonatomic,assign) BOOL canSendText;

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
    self.tableView.tableHeaderView = self.headerView;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
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
                  
         TPTripDetailViewController* vc = [[UIStoryboard storyboardWithName:@"TPTripDetailViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tptripdetail"];
         vc.oid = self.orderId;
         [self.navigationController pushViewController:vc animated:true];
         // 跳转旅程列表
         /*[[[[UIApplication sharedApplication].delegate window] viewWithTag:996]removeFromSuperview];
         [self.tabBarController setSelectedIndex:2];
         [self.navigationController popToRootViewControllerAnimated:true];*/
         
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

    [self layoutHeaderView];
    [self scrollToBottom:NO];
//    if (self.canSendText) {
        [TPGrowingTextView showInView:self.view delegate:self];
//    }
    
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

- (void)setOrderStatus:(NSString *)orderStatus
{
    _orderStatus = orderStatus;
    self.canSendText = YES;
    switch ([_orderStatus integerValue]) {
        case kOrderFinished:
            self.canSendText = NO;
            break;
        case kOrderInvalid:
            self.canSendText = NO;
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
    self.orderStatus = self.headerView.orderStatus;
    [self setOrderStatus:(NSString *)self.headerView.orderStatus];
    
    if (!self.canSendText) {
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
//    self.tableView.vzOrigin = 
}
- (void)textViewDidHid
{
    self.tableView.vzOrigin = CGPointMake(0, 0);
}

- (void)scrollToBottom:(BOOL)animated
{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.tableView.vzWidth, CGFLOAT_MAX) animated:animated];
}

- (void)layoutHeaderView
{
    self.headerView = [[TPChatListHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 44)];
    self.headerView.dateLabel.text = [NSString stringWithFormat:@"%@ / %@人",self.chatListModel.serviceDate,self.chatListModel.peopleNum];
    self.headerView.actionBtn.hidden = NO;
    self.headerView.insiderId = self.chatListModel.insiderId;
    self.headerView.orderStatus = self.chatListModel.orderStatus;

    __weak typeof(self) weakSelf = self;
    self.headerView.callback = ^(NSString* orderStatus){
        
        if ([orderStatus integerValue] == kOrderReadyConfirm)
        {
            if ([TPUser type] == kCustomer) {
                
                //去修改
                TPReserveViewController* v = [[UIStoryboard storyboardWithName:@"TPReserveViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tpreservedetail"];
                v.type=kModifyOrder;
                v.sid = weakSelf.chatListModel.serviceId;
                v.maxNum = 6;
                v.oid = weakSelf.orderId;
                v.insiderId = weakSelf.chatListModel.insiderId;
                v.servicePrice = weakSelf.chatListModel.servicePrice;
                v.serviceName = weakSelf.chatListModel.serviceName;
                v.moneyType = weakSelf.chatListModel.moneyType;
                [weakSelf.navigationController pushViewController:v animated:true];
            }
            else
            {
                //去旅行详情
                TPTripDetailViewController* vc = [[UIStoryboard storyboardWithName:@"TPTripDetailViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tptripdetail"];
                vc.oid = weakSelf.chatListModel.orderId;
                [weakSelf.navigationController pushViewController:vc animated:true];
                
            }
        }
        else if ([orderStatus integerValue] == kOrderReadyPay)
        {
            if ([TPUser type] == kCustomer) {
                
                //去支付
                TPPayViewController* vc = [[UIStoryboard storyboardWithName:@"TPPayViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tppay"];
                vc.oid = weakSelf.orderId;
                [weakSelf.navigationController pushViewController:vc animated:true];
            }
           
        }
        else
        {
        }
    };
    
    self.tableView.tableHeaderView = self.headerView;
}


@end
 
