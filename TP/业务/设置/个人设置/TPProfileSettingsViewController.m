//
//  TPProfileSettingsViewController.m
//  TP
//
//  Created by moxin on 15/6/7.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPProfileSettingsViewController.h"
#import "TPProfileUpdateViewController.h"
#import "ETImageTransformTool.h"

@interface TPProfileSettingsViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView* tableView;

@end

@implementation TPProfileSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"个人设置"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, self.view.vzHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [TPUIKit emptyView];
    [self.view addSubview:self.tableView];
    
    UIView* footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.vzWidth, 160)];
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.vzWidth-200)/2, 20, 200, 44)];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = true;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setBackgroundColor:[TPTheme themeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        
        [WCAlertView showAlertWithTitle:@"" message:@"确定要退出登录吗?" customizationBlock:^(WCAlertView *alertView) {
            
        } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            
            if (buttonIndex == 1) {
                [TPLoginManager logout];
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
    }];
    [footerView addSubview:btn];
    self.tableView.tableFooterView = footerView;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    else
        return 44;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString* pkey = @"TPProfileSettingsViewController";


    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:pkey];
        cell.selectionStyle = 0;
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = ft(16.0f);
        cell.textLabel.textColor = [TPTheme blackColor];
        
        cell.detailTextLabel.font = ft(14.0f);
        cell.detailTextLabel.textColor = [TPTheme grayColor];
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            UIImageView* icon = [UIImageView new];
            icon.layer.cornerRadius = 0.5*40;
            icon.layer.masksToBounds = true;
            icon.vzOrigin = CGPointMake(self.view.vzWidth-80, 10);
            icon.vzSize = CGSizeMake(40, 40);
            icon.image = __image(@"girl.jpg");
            [icon sd_setImageWithURL:__url([TPUser avatar]) placeholderImage:__image(@"girl.jpg")];
            icon.tag = 100;
            [cell.contentView addSubview:icon];
            cell.textLabel.text = @"设置头像";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"手机";
            cell.detailTextLabel.text = [TPUser mobile];
            break;
        }
            
        case 2:
        {
            cell.textLabel.text = @"姓名";
            
            if ([TPUser userName].length > 0) {
                cell.detailTextLabel.text = [TPUser userName];
            }
            else
            {
                cell.detailTextLabel.text = @"未设置";
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case 3:
        {
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = [TPUser userNick].length > 0 ? [TPUser userNick]:@"未设置";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 4:
        {
            cell.textLabel.text = @"性别";
            NSString* text = [TPUser gender];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }

            break;
        }
        case 5:
        {
            cell.textLabel.text = @"地区";
            NSString* text = [TPUser city];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case 6:
        {
            cell.textLabel.text = @"职业";
            NSString* text = [TPUser career];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case 7:
        {
            cell.textLabel.text = @"爱好";
            NSString* text = [TPUser hobby];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
        case 8:
        {
            cell.textLabel.text = @"语言";
            NSString* text = [TPUser language];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
      
        }
        case 9:
        {
            cell.textLabel.text = @"签名";
            NSString* text = [TPUser sign];
            cell.detailTextLabel.text = text.length == 0?text:@"未设置";
            if (text.length == 0) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        }
            
        default:
            break;
    }

    return cell;

}


/**
 	uid(String): 用户id
 	token(String):  登录凭证
 	realName(String)：真实姓名
 	nick(String)：昵称
 	gender(String)：性别
 	city(String)：城市
 	language(String)：语言
 	career(String)：职业
 	interests(String)：兴趣
 	sign(String)：用户签名
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* title = @"";
    NSString* key = @"";
    NSString* hintString = @"";
    BOOL isLongText = NO;
    
    switch (indexPath.row) {
        case 0:
        {
            [self uploadHeadPic];
            //break;
            return;
      
        }
        case 1:
        {
            return;
        }
        case 2:
        {
            title = @"设置姓名";
            key = @"realName";
            hintString = @"请填写真实姓名，设定后不可修改";
            break;
        }
        
        case 3:
        {
            title = @"设置昵称";
            key = @"nick";
            hintString = @"昵称30天只能修改一次";
            break;
        }
        case 4:
        {
            return;
        }
            
        case 5:
        {
            title = @"设置地区";
            key = @"city";
            break;
        }
            
        case 6:
        {
            title = @"设置职业";
            key = @"career";
            break;
        }
            
        case 7:
        {
            title = @"设置爱好";
            key = @"interests";
            break;
        }
            
        case 8:
        {
            title = @"设置语言";
            key = @"language";
            break;
        }
            
        case 9:
        {
            title = @"设置签名";
            key = @"sign";
            isLongText = true;
            break;
        }
            
        default:
            break;
    }
    
    TPProfileUpdateViewController* vc = [TPProfileUpdateViewController new];
    vc.key = key;
    vc.title = title;
    vc.hintText = hintString;
    vc.longText = isLongText;
    vc.callback = ^{[self.tableView reloadData];};
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:true completion:nil];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 200)
    {
        NSInteger sourceType = 0;
        //判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    //取消
                    return;
                    break;
                case 1:
                    //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
        }else
        {
            if (buttonIndex == 0)
            {
                return;
            }else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        //跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = sourceType;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)uploadHeadPic
{
    UIActionSheet *sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else
    {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 200;
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        [self.view makeToastActivity];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage* clippedImage = [image tranformScaleToSize:CGSizeMake(640, 640)];
            NSString* base64String = [self processImage:clippedImage];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.view hideToastActivity];
                
                NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
                UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
                UIImageView* icon = (UIImageView* )[cell.contentView viewWithTag:100];
                icon.image = clippedImage;
                [self uploadPics:base64String];
            });
            
        });
        
    }];
}


- (NSString* )processImage:(UIImage* )image
{
    NSData* data = nil;
    data = UIImageJPEGRepresentation(image, 0.5);

    return  [data base64Encoding];
}

- (void)uploadPics:(NSString* )base64
{
    //SHOW_SPINNER(self);
    [TPUtils uploadImage:base64 WithCompletion:^(NSString *url, NSError *err) {
    
        if (!err) {
            
            NSDictionary* dict = @{
                                   @"uid":[TPUser uid]?:@"",
                                   @"token":[TPUser token]?:@"",
                                   @"headPic":url?:@""
                                       };
            
            [TPUser updateUserProfile:[dict copy] withCompletion:^(NSError *error) {
                
                if (!error) {
                    [TPUser changeAvatar:url];
                }
            }];
            
        }
        else
        {
            //TOAST_ERROR(self, err);
        }
        
    }];
    
}



@end
