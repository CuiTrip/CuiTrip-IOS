  
//
//  TPPublishCommentModelTest.m
//  TP
//
//  Created by moxin on 2015-06-11 19:56:48 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPPublishCommentModel.h"

@interface TPPublishCommentModelTest : XCTestCase

@property(nonatomic,strong)TPPublishCommentModel* tPPublishCommentModel;

@end

@implementation TPPublishCommentModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPPublishCommentModel = [TPPublishCommentModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPPublishCommentModel cancel];
    self.tPPublishCommentModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPPublishCommentModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPPublishCommentModel* tPPublishCommentModel = (TPPublishCommentModel* )model;
        if (!error)
        {
        
        }
        else
        {
            XCTFail(@"Connection Failed:%@",error);
        }

        waitingForBlock = NO;
        
    }];
    
    while (waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

@end

