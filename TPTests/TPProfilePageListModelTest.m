  
//
//  TPProfilePageListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-04 00:05:25 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPProfilePageListModel.h"

@interface TPProfilePageListModelTest : XCTestCase

@property(nonatomic,strong)TPProfilePageListModel* tPProfilePageListModel;

@end

@implementation TPProfilePageListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPProfilePageListModel = [TPProfilePageListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPProfilePageListModel cancel];
    self.tPProfilePageListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPProfilePageListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPProfilePageListModel* tPProfilePageListModel = (TPProfilePageListModel* )model;
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

