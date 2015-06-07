  
//
//  TPFeedbackModelTest.m
//  TP
//
//  Created by moxin on 2015-06-07 10:02:38 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPFeedbackModel.h"

@interface TPFeedbackModelTest : XCTestCase

@property(nonatomic,strong)TPFeedbackModel* tPFeedbackModel;

@end

@implementation TPFeedbackModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPFeedbackModel = [TPFeedbackModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPFeedbackModel cancel];
    self.tPFeedbackModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPFeedbackModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPFeedbackModel* tPFeedbackModel = (TPFeedbackModel* )model;
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

