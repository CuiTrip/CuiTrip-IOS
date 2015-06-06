  
//
//  TPForgetPWDModelTest.m
//  TP
//
//  Created by moxin on 2015-06-06 17:11:51 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPForgetPWDModel.h"

@interface TPForgetPWDModelTest : XCTestCase

@property(nonatomic,strong)TPForgetPWDModel* tPForgetPWDModel;

@end

@implementation TPForgetPWDModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPForgetPWDModel = [TPForgetPWDModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPForgetPWDModel cancel];
    self.tPForgetPWDModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPForgetPWDModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPForgetPWDModel* tPForgetPWDModel = (TPForgetPWDModel* )model;
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

