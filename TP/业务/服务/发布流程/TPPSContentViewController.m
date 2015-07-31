//
//  TPPSContentViewController.m
//  TP
//
//  Created by zhou li on 15/7/30.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPPSContentViewController.h"
#import "TPPSAccessoryView.h"
#import "TPPSImageView.h"

#define MAX_IMAGE_COUNT  9


@interface TPPSContentViewController()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SETextView *textView;
@property (nonatomic, strong) TPPSAccessoryView *inputAccessoryView;
@property(nonatomic,strong) O2OCommentImageListView* galleryView;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) int index;



@end

@implementation TPPSContentViewController

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"旅程"];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 0;
    self.content = @"";
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, self.view.vzWidth - 10.0f, self.view.vzHeight)];
    [self.view addSubview:self.scrollView];
    
    self.inputAccessoryView = [[TPPSAccessoryView alloc] initWithFrame : CGRectMake(0.0f, 0.0f, self.view.vzWidth, 44.0f)];
    self.inputAccessoryView.keyDownBtn.target = self;
    self.inputAccessoryView.keyDownBtn.action = @selector(hideKeyboard);
    self.inputAccessoryView.addImageBtn.target = self;
    self.inputAccessoryView.addImageBtn.action = @selector(showImagePicker);
    
    self.textView = [[SETextView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, self.view.vzWidth - 10.0f, self.view.vzHeight)];
    self.textView.inputAccessoryView = self.inputAccessoryView;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    NSString *initialText = @"1";
    self.textView.text = initialText;
    self.textView.font = [UIFont systemFontOfSize:18.0f];
    self.textView.delegate = self;
    [self.scrollView addSubview:self.textView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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


///////////////////////
#pragma mark - btn action 

- (void)hideKeyboard
{
    [self.textView resignFirstResponder];
}

- (void)showImagePicker
{
    [self.textView resignFirstResponder];
    UIActionSheet *sheet;
    NSString* title = [NSString stringWithFormat:@"你还可以上传%lu张图片", MAX_IMAGE_COUNT - [self.galleryView.imageItems count]];
    
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

- (void)done
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

//////////////////////
#pragma mark - notify

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
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
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
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


/////////////////////////////
#pragma mark - delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
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
    }
    else
    {
        if (buttonIndex == 0)
        {
            return;
        }
        else
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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    TPPSImageView *photoView = [[TPPSImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kTPScreenWidth - 0.0f, (image.size.height * kTPScreenWidth) / image.size.width)];
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
                long Len = self.textView.selectedRange.location;
                NSString *allString = self.textView.text;
                NSString *stringToCursor = [allString substringToIndex:Len];
                NSLog(@"imagePickerController: %@ at: %ld", stringToCursor, Len);
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


- (void)textViewDidChange:(SETextView *)textView
{
    [self updateLayout];
}






@end

