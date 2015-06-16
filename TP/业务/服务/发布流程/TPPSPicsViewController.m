//
//  TPPSPicsViewController.m
//  TP
//
//  Created by moxin on 15/6/11.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSPicsViewController.h"
#import "O2OCommentImageListView.h"
#import "ETImageTransformTool.h"
#import "O2OCommentImageItem.h"
#import "O2OCommentImageView.h"


const int kMaxImageCount = 9;
@interface TPPSPicsViewController ()<O2OCommentImageListViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) O2OCommentImageListView* galleryView;
@property(nonatomic, strong) UIView *imgsBackView;
@property(nonatomic,strong) O2OCommentImageItem* tobeDeletedItem;

@end

@implementation TPPSPicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _galleryView  = [[O2OCommentImageListView alloc] initWithFrame:CGRectMake(10, 60, self.view.vzWidth-30, 55)];
    _galleryView.enableAddImage = YES;
    _galleryView.delegate = self;
    _galleryView.maxCount = kMaxImageCount;

    [self.view addSubview:_galleryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onNext
{
    NSArray* items = self.galleryView.imageItems;
    NSMutableArray* list = [NSMutableArray new];
    for (O2OCommentImageItem* item in items) {
        
        if (item.base64String) {
            [list addObject:item.base64String];
        }

    }
    
    if (self.callback) {
        self.callback([list copy],nil);
    }
}
- (void)onBack
{
    
}

- (void)onImageClick:(O2OCommentImageView *)imageView
{
    NSUInteger index = [_galleryView.imageViews indexOfObject:imageView];
    
    if (index == NSNotFound) {
        return;
    }
    
    if (imageView == _galleryView.addImageView) {
        [self onAddImgBtnClick];
    } else {
        
        //删除
        self.tobeDeletedItem = imageView.item;
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:@"删除图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
        sheet.tag = 201;
        [sheet showFromTabBar:self.tabBarController.tabBar];
        
        
       // [WWPhotoBrowser showPhotoBrowserInPublishSellerCommentSceneWithIndex:index delegate:self];
    }
}

- (void)onAddImgBtnClick
{
    UIActionSheet *sheet;
     NSUInteger remainCount = kMaxImageCount - [_galleryView.imageItems count] + 1;
    NSString* title = [NSString stringWithFormat:@"你还可以上传%lu张图片", remainCount];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else
    {
        sheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 200;
    [sheet showFromTabBar:self.tabBarController.tabBar];
    
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
    
    if (actionSheet.tag == 201) {
        
        if (buttonIndex == 1) {
            return;
        }
        else
        {
            [self.galleryView removeImage:self.tobeDeletedItem];
            self.tobeDeletedItem = nil;
        }
    }
}

#pragma mark -- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
        [self.view makeToastActivity];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage* clippedImage = [image tranformScaleToSize:CGSizeMake(640, 640)];
            NSString* base64String = [self processImage:clippedImage];
            
            O2OCommentImageItem* photoItem = [O2OCommentImageItem new];
            photoItem.size = CGSizeMake(100, 100);
            photoItem.image = clippedImage;
            photoItem.needAutoUpload = NO;
            photoItem.base64String = base64String;

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.view hideToastActivity];
                
                [_galleryView appendImage:photoItem];
                
            });
            
        });
        
    }];
}

- (NSString* )processImage:(UIImage* )image
{
    NSData* data = nil;
//    if ([[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi]) {
//        
//        data = UIImageJPEGRepresentation(image, 0.8);
//    }
//    else
//    {
        data = UIImageJPEGRepresentation(image, 0.5);
//    }
    
    return  [data base64Encoding];
}


@end
