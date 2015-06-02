  
//
//  TPTripListModelTest.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:29 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPTripListModel.h"

@interface TPTripListModelTest : XCTestCase

@property(nonatomic,strong)TPTripListModel* tPTripListModel;

@end

@implementation TPTripListModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPTripListModel = [TPTripListModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPTripListModel cancel];
    self.tPTripListModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPTripListModel loadWithCompletion:^(VZHTTPListModel *model, NSError *error) {
       

        TPTripListModel* tPTripListModel = (TPTripListModel* )model;
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

