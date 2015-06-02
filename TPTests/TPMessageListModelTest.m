  
//
//  TPMessageListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPMessageListModel.h"

@interface TPMessageListModelTest : XCTestCase

@property(nonatomic,strong)TPMessageListModel* tPMessageListModel;

@end

@implementation TPMessageListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPMessageListModel = [TPMessageListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPMessageListModel cancel];
    self.tPMessageListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPMessageListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPMessageListModel* tPMessageListModel = (TPMessageListModel* )model;
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

