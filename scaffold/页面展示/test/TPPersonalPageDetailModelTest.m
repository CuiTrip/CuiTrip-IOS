  
//
//  TPPersonalPageDetailModelTest.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:39 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPPersonalPageDetailModel.h"

@interface TPPersonalPageDetailModelTest : XCTestCase

@property(nonatomic,strong)TPPersonalPageDetailModel* tPPersonalPageDetailModel;

@end

@implementation TPPersonalPageDetailModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPPersonalPageDetailModel = [TPPersonalPageDetailModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPPersonalPageDetailModel cancel];
    self.tPPersonalPageDetailModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPPersonalPageDetailModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPPersonalPageDetailModel* tPPersonalPageDetailModel = (TPPersonalPageDetailModel* )model;
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

