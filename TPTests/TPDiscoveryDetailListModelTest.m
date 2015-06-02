  
//
//  TPDiscoveryDetailListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-02 22:32:08 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPDiscoveryDetailListModel.h"

@interface TPDiscoveryDetailListModelTest : XCTestCase

@property(nonatomic,strong)TPDiscoveryDetailListModel* tPDiscoveryDetailListModel;

@end

@implementation TPDiscoveryDetailListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPDiscoveryDetailListModel = [TPDiscoveryDetailListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPDiscoveryDetailListModel cancel];
    self.tPDiscoveryDetailListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPDiscoveryDetailListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPDiscoveryDetailListModel* tPDiscoveryDetailListModel = (TPDiscoveryDetailListModel* )model;
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

