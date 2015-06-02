  
//
//  TPMyServiceListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-01 19:52:11 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPMyServiceListModel.h"

@interface TPMyServiceListModelTest : XCTestCase

@property(nonatomic,strong)TPMyServiceListModel* tPMyServiceListModel;

@end

@implementation TPMyServiceListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPMyServiceListModel = [TPMyServiceListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPMyServiceListModel cancel];
    self.tPMyServiceListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPMyServiceListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPMyServiceListModel* tPMyServiceListModel = (TPMyServiceListModel* )model;
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

