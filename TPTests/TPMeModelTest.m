  
//
//  TPMeModelTest.m
//  TP
//
//  Created by moxin on 2015-06-01 19:41:46 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPMeModel.h"

@interface TPMeModelTest : XCTestCase

@property(nonatomic,strong)TPMeModel* tPMeModel;

@end

@implementation TPMeModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPMeModel = [TPMeModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPMeModel cancel];
    self.tPMeModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPMeModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPMeModel* tPMeModel = (TPMeModel* )model;
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

