//
//  TPDiscoveryDetailContentViewController.m
//  TP
//  发现详情页，点击查看详情后的跳转页面，需要修改为图文混排详情页
//  Created by moxin on 15/6/3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "TPDiscoveryDetailContentViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "SEPhotoView.h"
#import "SETextView.h"

static const CGFloat defaultFontSize = 18.0f;
@interface TPDiscoveryDetailContentViewController ()


@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UILabel* titleLabel;

@property(nonatomic, strong)  SETextView *textView;

@property (nonatomic) id normalFont;


@end

@implementation TPDiscoveryDetailContentViewController


- (void)viewDidLoad
{

    [super viewDidLoad];    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = HEXCOLOR(0xfffaf1);

    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15.0f, self.navigationItem.titleView.vzBottom, self.view.vzWidth - 30.0f, self.view.vzHeight)];
    [self.view addSubview:self.scrollView];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.vzWidth-40, 18)];
    self.titleLabel.textColor = HEXCOLOR(0x4a4a4a);
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.text = self.titleString;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;
    [self.scrollView addSubview:self.titleLabel];

    
    self.textView = [[SETextView alloc] initWithFrame:CGRectMake(5.0f, self.titleLabel.vzBottom+20, self.view.vzWidth - 10.0f, self.scrollView.vzHeight-20-self.titleLabel.vzHeight)];
    self.textView.inputAccessoryView = self.inputAccessoryView;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    NSString *initialText = @"";
    self.textView.text = initialText;
    self.textView.font = [UIFont systemFontOfSize:18.0f];
    self.textView.delegate = self;
    [self.scrollView addSubview:self.textView];

    self.textView.editable = NO;
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
    
    HIDE_SPINNER(self);
    
    
    //todo:
    
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
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    self.textView.text = @"";
    
    NSString *preText = [self getPreText:_content];
    NSString *imgUrl = [self getImgUrl:_content];
    while (![imgUrl  isEqual: @""] || ![preText  isEqual: @""]) {
        if (![preText  isEqual: @""])
        {
            [self.textView insertText:preText];
        }
        if (![imgUrl  isEqual: @""])
        {
            UIImageView *asyncImage = [[UIImageView alloc] init];
            [asyncImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:__image(@"default_details.jpg")];
            
            UIImage *image = asyncImage.image;
            SEPhotoView *photoView = [[SEPhotoView alloc] initWithFrame:CGRectMake(15.0f, 20.0f, kTPScreenWidth-30, (image.size.height * kTPScreenWidth)/image.size.width)];
            
            [self.textView insertObject:asyncImage size:photoView.bounds.size];
        }
        
        [self updateLayout];
        preText = [self getPreText:_content];
        imgUrl = [self getImgUrl:_content];
    }
    
}

- (NSString*)getPreText:(NSString*)srcStr
{
    NSString* result = @"";
    NSString* urlPre = [NSString stringWithFormat:@"<div>< img src=\""];
    NSString* urlSub = [NSString stringWithFormat:@"\" width=\"100\%\" \/><\/div>"];
    NSRange rang1 = [srcStr rangeOfString:urlPre
                                  options:NSBackwardsSearch
                                    range:NSMakeRange(0, srcStr.length)
                                   locale:nil];
    NSRange rang2 = [srcStr rangeOfString:urlSub
                                  options:NSBackwardsSearch
                                    range:NSMakeRange(0, srcStr.length)
                                   locale:nil];
    
    if (rang1.location != NSNotFound && rang2.location != NSNotFound) {
        result = [_content substringWithRange:NSMakeRange(rang2.location+rang2.length, srcStr.length-rang2.location-rang2.length)];
        _content = [_content stringByReplacingCharactersInRange:NSMakeRange(rang2.location+rang2.length, srcStr.length-rang2.location-rang2.length) withString:@""];
    }
    else if(_content.length > 0)
    {
        result = [_content substringWithRange:NSMakeRange(0, srcStr.length)];
        _content = @"";
    }
    return result;
}

- (NSString*)getImgUrl:(NSString*)srcStr
{
    NSString* result = @"";
    NSString* urlPre = [NSString stringWithFormat:@"<div>< img src=\""];
    NSString* urlSub = [NSString stringWithFormat:@"\" width=\"100\%\" \/><\/div>"];
    NSRange rang1 = [_content rangeOfString:urlPre
                                    options:NSBackwardsSearch
                                      range:NSMakeRange(0, _content.length)
                                     locale:nil];
    NSRange rang2 = [_content rangeOfString:urlSub
                                    options:NSBackwardsSearch
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
    frame.size.height = MAX(contentSize.height, containerSize.height) + 160.0F;
    
    self.textView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    [self.scrollView scrollRectToVisible:self.textView.caretRect animated:YES];
}


@end
