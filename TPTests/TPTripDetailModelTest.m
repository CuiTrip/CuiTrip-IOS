  
//
//  TPTripDetailModelTest.m
//  TP
//
//  Created by moxin on 2015-06-07 21:28:19 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPTripDetailModel.h"

@interface TPTripDetailModelTest : XCTestCase

@property(nonatomic,strong)TPTripDetailModel* tPTripDetailModel;

@end

@implementation TPTripDetailModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPTripDetailModel = [TPTripDetailModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPTripDetailModel cancel];
    self.tPTripDetailModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPTripDetailModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPTripDetailModel* tPTripDetailModel = (TPTripDetailModel* )model;
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

