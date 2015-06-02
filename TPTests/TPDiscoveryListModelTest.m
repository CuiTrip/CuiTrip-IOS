  
//
//  TPDiscoveryListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-01 19:38:20 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPDiscoveryListModel.h"

@interface TPDiscoveryListModelTest : XCTestCase

@property(nonatomic,strong)TPDiscoveryListModel* tPDiscoveryListModel;

@end

@implementation TPDiscoveryListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPDiscoveryListModel = [TPDiscoveryListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPDiscoveryListModel cancel];
    self.tPDiscoveryListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPDiscoveryListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPDiscoveryListModel* tPDiscoveryListModel = (TPDiscoveryListModel* )model;
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

