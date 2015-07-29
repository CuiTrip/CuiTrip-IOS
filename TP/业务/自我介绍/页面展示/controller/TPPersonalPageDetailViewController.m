  
//
//  TPPersonalPageDetailViewController.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:39 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>


#import "TPPersonalPageDetailViewController.h"
#import "TPPersonalPageViewController.h"
#import "TPPersonalPageDetailModel.h"

#import "SEPhotoView.h"
#import "SETextView.h"

static const CGFloat defaultFontSize = 18.0f;

@interface TPPersonalPageDetailViewController()<SETextViewDelegate ,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

 
@property(nonatomic,strong)TPPersonalPageDetailModel *personalPageDetailModel; 

@property(nonatomic,strong) NSString* content;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet SETextView *textView;

@property (nonatomic) id normalFont;

@end

@implementation TPPersonalPageDetailViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (TPPersonalPageDetailModel *)personalPageDetailModel
{
    if (!_personalPageDetailModel) {
        _personalPageDetailModel = [TPPersonalPageDetailModel new];
        _personalPageDetailModel.key = @"__TPPersonalPageDetailModel__";
    }
    return _personalPageDetailModel;
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
    [self setTitle:@"介绍自己"];
    //todo..
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.inputAccessoryView = [[[UINib nibWithNibName:@"SEInputAccessoryView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    //    NSString *initialText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InitialText" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSString *initialText = @"关于您自己的介绍，可以包含您的个人生活照。这是您的主页，所以要很认真的编写哦！";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:initialText];
    
    
    UIFont *normalFont = [UIFont systemFontOfSize:defaultFontSize];
    CTFontRef ctNormalFont = CTFontCreateWithName((__bridge CFStringRef)normalFont.fontName, normalFont.pointSize, NULL);
    self.normalFont = (__bridge id)ctNormalFont;
    CFRelease(ctNormalFont);
    
    
    [attributedString addAttribute:(id)kCTFontAttributeName value:self.normalFont range:NSMakeRange(0, initialText.length)];
    self.textView.font = self.normalFont;
    self.textView.attributedText = attributedString;
    
    self.doneButton.enabled = YES;
    self.textView.editable = NO;
    [self registerModel:self.personalPageDetailModel];
    [self load];
    
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
    
    HIDE_SPINNER(self);

    
    //todo:
    [self setupView];
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



- (void)textViewDidChange:(SETextView *)textView
{
    self.textView.font = self.normalFont;
    [self updateLayout];
}

#pragma mark -
- (void)setupView
{
    self.textView.text = self.personalPageDetailModel.introduce;
    _content = self.textView.text;
    
    NSString *imgUrl = [self getImgUrl:_content];
    while (![imgUrl  isEqual: @""]) {
        
        UIImageView *asyncImage = [[UIImageView alloc] init];
        [asyncImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:__image(@"default_details.jpg")];
//        [asyncImage 
        
        UIImage *image = asyncImage.image;
        SEPhotoView *photoView = [[SEPhotoView alloc] initWithFrame:CGRectMake(15.0f, 20.0f, kTPScreenWidth-30, (image.size.height * kTPScreenWidth)/image.size.width)];
        photoView.image = image;
        [self.textView insertText:_content];
        [self.textView insertObject:photoView size:photoView.bounds.size];
//        [self updateLayout];
        imgUrl = [self getImgUrl:_content];
    }
    
}

- (NSString*)getImgUrl:srcStr
{
    NSString* result = @"";
    NSString* urlPre = [NSString stringWithFormat:@"<div>< img src=\""];
    NSString* urlSub = [NSString stringWithFormat:@"\" width=\"100\%\" \/><\/div>"];
    NSRange rang1 = [_content rangeOfString:urlPre
                                    options:NSRegularExpressionSearch
                                      range:NSMakeRange(0, _content.length)
                                     locale:nil];
    NSRange rang2 = [_content rangeOfString:urlSub
                                    options:NSRegularExpressionSearch
                                      range:NSMakeRange(0, _content.length)
                                     locale:nil];
    
    if (rang1.location != NSNotFound && rang2.location != NSNotFound) {
        result = [_content substringWithRange:NSMakeRange(rang1.location+rang1.length, rang2.location-rang1.location-rang1.length)];
        _content = [_content stringByReplacingCharactersInRange:NSMakeRange(rang1.location, rang2.location+rang2.length-rang1.location) withString:@""];
    }
    return result;
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
    TPPersonalPageViewController* vc = __story(@"TPPersonalPageViewController",@"tppersonal");
    [self.navigationController pushViewController:vc animated:true];
    //        loc.callback = ^(NSString* location,...){self.location = location;};
}



@end


 
