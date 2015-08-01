  
//
//  TPPersonalPageViewController.m
//  TP
//
//  Created by wifigo on 2015-07-28 13:09:52 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//



#import "TPPersonalPageViewController.h"
 
#import "TPPersonalPageModel.h" 

#import "TPPSAccessoryView.h"
#import "SEPhotoView.h"
#import "SETextView.h"
#import "SETextInput.h"
#import "SETextLayout.h"

#import "O2OCommentImageListView.h"
#import "ETImageTransformTool.h"
#import "O2OCommentImageItem.h"
#import "O2OCommentImageView.h"



const int kMaxUserImageCount = 9;

static const CGFloat defaultFontSize = 18.0f;


@interface TPPersonalPageViewController() <SETextViewDelegate, O2OCommentImageListViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong) O2OCommentImageListView* galleryView;
@property(nonatomic,strong) O2OCommentImageItem* tobeDeletedItem;
@property(nonatomic,strong) NSMutableArray* picsList;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet SETextView *textView;

@property (nonatomic) TPPSAccessoryView *inputAccessoryView;
@property(nonatomic,strong)TPPersonalPageModel *personalPageModel;

@property (nonatomic, assign) int index;

@property (nonatomic) id normalFont;

@end

@implementation TPPersonalPageViewController


//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPersonalPageModel *)personalPageModel
{
    if (!_personalPageModel) {
        _personalPageModel = [TPPersonalPageModel new];
        _personalPageModel.key = @"__TPPersonalPageModel__";
    }
    return _personalPageModel;
}



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"介绍自己"];
    self.doneButton.title = @"提交";
    //todo..
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index = 0;
    _picsList = [NSMutableArray new];
    _galleryView  = [[O2OCommentImageListView alloc] initWithFrame:CGRectMake(10, 60, self.view.vzWidth-30, 55)];
    _galleryView.enableAddImage = YES;
    _galleryView.delegate = self;
    _galleryView.maxCount = kMaxUserImageCount;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputAccessoryView = [[TPPSAccessoryView alloc] initWithFrame : CGRectMake(0.0f, 0.0f, self.view.vzWidth, 44.0f)];
    self.inputAccessoryView.keyDownBtn.target = self;
    self.inputAccessoryView.keyDownBtn.action = @selector(hideKeyboard);
    self.inputAccessoryView.addImageBtn.target = self;
    self.inputAccessoryView.addImageBtn.action = @selector(showImagePicker);
    self.textView.inputAccessoryView = self.inputAccessoryView;
    
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    NSString *initialText = @"关于您自己的介绍，可以包含您的个人生活照。这是您的主页，所以要很认真的编写哦！";
    

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:initialText];
    
    UIFont *normalFont = [UIFont systemFontOfSize:defaultFontSize];
    CTFontRef ctNormalFont = CTFontCreateWithName((__bridge CFStringRef)normalFont.fontName, normalFont.pointSize, NULL);
    self.normalFont = (__bridge id)ctNormalFont;
    CFRelease(ctNormalFont);
    
    [attributedString addAttribute:(id)kCTFontAttributeName value:self.normalFont range:NSMakeRange(0, initialText.length)];
    self.textView.font = self.normalFont;
    self.textView.attributedText = attributedString;
    self.textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupView];

}

- (void)viewWillLayoutSubviews
{
    [self updateLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
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
#pragma mark - @override methods

- (void)showModel:(VZModel *)model
{
    //todo:
    [super showModel:model];
}

- (void)showEmpty:(VZModel *)model
{
    //todo:
    [super showEmpty:model];
}


- (void)showLoading:(VZModel*)model
{
    //todo:
    [super showLoading:model];
}

- (void)showError:(NSError *)error withModel:(VZModel*)model
{
    //todo:
    [super showError:error withModel:model];
}

#pragma mark -

- (void)textViewDidBeginEditing:(SETextView *)textView
{
    self.doneButton.enabled = YES;
}

- (void)textViewDidEndEditing:(SETextView *)textView
{
    self.doneButton.enabled = YES;
}

- (void)textViewDidChangeSelection:(SETextView *)textView
{
    NSRange selectedRange = textView.selectedRange;
    if (selectedRange.location != NSNotFound && selectedRange.length > 0) {
//        self.inputAccessoryView.boldButton.enabled = YES;
//        self.inputAccessoryView.nomalButton.enabled = YES;
    } else {
//        self.inputAccessoryView.boldButton.enabled = NO;
//        self.inputAccessoryView.nomalButton.enabled = NO;
    }
}

- (void)textViewDidChange:(SETextView *)textView
{
    self.textView.font = self.normalFont;

    [self updateLayout];
}

#pragma mark -

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:self.textView];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(keyboardBounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:self.textView];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
    
}

- (void)updateLayout
{
    CGSize containerSize = self.scrollView.frame.size;
    CGSize contentSize = [self.textView sizeThatFits:containerSize];
    
    CGRect frame = self.textView.frame;
    frame.size.height = MAX(contentSize.height, containerSize.height);
    
    self.textView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    [self.scrollView scrollRectToVisible:self.textView.caretRect animated:YES];
}


////////////////////////////////
#pragma mark - button action


- (IBAction)done:(id)sender
{
    [self.textView resignFirstResponder];
    [self processText];
    
    BOOL isPicUploading = false;
    NSArray* items = self.galleryView.imageItems;
    
    /////// <div>< img src="xxx" width="100%" /></div>
    
    for (O2OCommentImageItem* item in items)
    {
        
        if (item.isUploading) {
            isPicUploading = true;
            break;
        }
        
        if (item.imageURL) {
            [_picsList addObject:item.imageURL];
        }
        
    }
    
    if (isPicUploading)
    {
        TOAST(self, @"请等待图片上传完毕");
        return;
    }
    else if (_picsList.count == 0)
    {
        TOAST(self, @"请上传图片");
        return;
    }
    else
    {
        [self insertUrlInContent];
        [self updateIntroduce];
    }
    return;
    
}


- (void)updateIntroduce{
    [self.view endEditing:true];
    self.personalPageModel.content = self.content;
    
    SHOW_SPINNER(self);
    __weak typeof(self) weakSelf = self;
    [self.personalPageModel loadWithCompletion:^(VZModel *model, NSError *error) {
        
        HIDE_SPINNER(weakSelf);
        
        if (!error) {
            
            TOAST(weakSelf, @"提交成功!");
    
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:true];
            });
        }
        else
        {
            TOAST_ERROR(weakSelf, error);
        }
    }];
}



- (void)hideKeyboard
{
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    [self.textView resignFirstResponder];
}

- (void)showImagePicker
{
    [self.textView resignFirstResponder];

    [self onAddImgBtnClick];

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
    NSUInteger remainCount = kMaxUserImageCount - [_picsList count];
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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    SEPhotoView *photoView = [[SEPhotoView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kTPScreenWidth - 0.0f, (image.size.height * kTPScreenWidth) / image.size.width)];
    photoView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.view makeToastActivity];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 设置图片高宽比，会影响图片质量
            UIImage* clippedImage = [image tranformScaleToSize:CGSizeMake(800, 800)];
            NSString* base64String = [self processImage:clippedImage];
            
            O2OCommentImageItem* photoItem = [O2OCommentImageItem new];
            photoItem.size = CGSizeMake(100, 100);
            photoItem.image = clippedImage;
            photoItem.needAutoUpload = YES;
            photoItem.base64String = base64String;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view hideToastActivity];
                [self.galleryView appendImage:photoItem];
                photoView.image = clippedImage;

                [self.textView insertObject:photoView size:photoView.bounds.size tag:self.index];
                self.index++;
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


- (void)processText
{
    self.content = self.textView.text;
    NSMutableSet *set = [self.textView getAttachments];
    NSArray *attachments = [set.allObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        SETextAttachment *attachment1 = obj1;
        SETextAttachment *attachment2 = obj2;
        NSRange range1 = attachment1.range;
        NSRange range2 = attachment2.range;
        NSUInteger maxRange1 = NSMaxRange(range1);
        NSUInteger maxRange2 = NSMaxRange(range2);
        if (maxRange1 > maxRange2)
        {
            return NSOrderedDescending;
        }
        else if (maxRange1 < maxRange2)
        {
            return NSOrderedAscending;
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    NSRange range = [self.content rangeOfString:@"\U0000fffc"];
    if (range.length == 0) {
        self.content = self.textView.text;
        return;
    }
    for (int i = 0; i < attachments.count; ++i) {
        SETextAttachment *attachment = attachments[i];
        self.content = [self.content stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"<img%d>", attachment.tag]];
        range = [self.content rangeOfString:@"\U0000fffc"];
    }
    NSLog(@"%@", self.content);
}

-(void) insertUrlInContent
{
    for (int i = 0; i < _picsList.count; ++i) {
        NSRange range = [self.content rangeOfString:[NSString stringWithFormat:@"<img%d>",i]];
        NSString * formatUrl = [NSString stringWithFormat:@"<div>< img src=\"%@\" width=\"100\%\" \/><\/div>",_picsList[i]];
        if (range.location != NSNotFound && range.length > 0) {
            self.content = [self.content stringByReplacingCharactersInRange:range withString:formatUrl];
        }
    }

}

- (void)setupView
{
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.textView becomeFirstResponder];
    
    self.textView.text = @"";
    NSString *preText = [self getPreText:_content];
//    NSString *imgUrl = [self getImgUrl:_content];
    while (![preText  isEqual: @""]) {
        NSString* urlPre = [NSString stringWithFormat:@"http://cuitrip.oss-cn-shenzhen.aliyuncs.com"];
        NSRange rang1 = [preText rangeOfString:urlPre
                                        options:NSBackwardsSearch
                                          range:NSMakeRange(0, preText.length)
                                         locale:nil];

        
        if (rang1.location != NSNotFound && rang1.length > 0) {
            UIImageView *asyncImage = [[UIImageView alloc] init];
            [asyncImage sd_setImageWithURL:[NSURL URLWithString:preText] placeholderImage:__image(@"default_details.jpg")];
            
            UIImage *image = asyncImage.image;
            SEPhotoView *photoView = [[SEPhotoView alloc] initWithFrame:CGRectMake(15.0f, 20.0f, kTPScreenWidth-30, (image.size.height * kTPScreenWidth)/image.size.width)];
            
//                        self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length,0);
//                        [self.scrollView scrollRectToVisible:self.textView.frame animated:YES];
            
            [_picsList addObject:preText];
            //[self.textView insertObject:asyncImage size:photoView.bounds.size tag:self.index];
            [self.textView addObject:asyncImage size:photoView.bounds.size atIndex:self.textView.text.length tag:self.index];
            self.index++;
        }
        else
        {
            SETextLayout *textLayout = [self.textView getTextLayout];
            [textLayout setSelectionStart:self.textView.text.length];
            [textLayout setSelectionEndAtIndex:self.textView.text.length];
            [self.textView insertText:preText];
        }
        
        [self updateLayout];
        preText = [self getPreText:_content];
    }
    
}

- (NSString*)getPreText:(NSString*)srcStr
{
    NSString* result = @"";
    NSString* urlPre = [NSString stringWithFormat:@"<div>< img src=\""];
    NSString* urlSub = [NSString stringWithFormat:@"\" width=\"100\%\" \/><\/div>"];
    NSRange rang1 = [srcStr rangeOfString:urlPre
                                  options:NSRegularExpressionSearch
                                    range:NSMakeRange(0, srcStr.length)
                                   locale:nil];
    NSRange rang2 = [srcStr rangeOfString:urlSub
                                  options:NSRegularExpressionSearch
                                    range:NSMakeRange(0, srcStr.length)
                                   locale:nil];
    
    if (rang1.location != NSNotFound && rang2.location != NSNotFound) {
        // 先取到图片
        if (rang1.location == 0) {
            result = [_content substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-rang1.location-rang1.length)];
            _content = [_content stringByReplacingCharactersInRange:NSMakeRange(rang1.location, rang2.location+rang2.length-rang1.location) withString:@""];
        }
        else
        {
            result = [_content substringWithRange:NSMakeRange(0, rang1.location)];
            _content = [_content stringByReplacingCharactersInRange:NSMakeRange(0, rang1.location) withString:@""];
//            result = [_content substringWithRange:NSMakeRange(rang2.location+rang2.length, srcStr.length-rang2.location-rang2.length)];
//            _content = [_content stringByReplacingCharactersInRange:NSMakeRange(rang2.location+rang2.length, srcStr.length-rang2.location-rang2.length) withString:@""];
        }
    }
    else if(_content.length > 0)
    {
        result = [_content substringWithRange:NSMakeRange(0, srcStr.length)];
        _content = @"";
    }
    return result;
}


@end

