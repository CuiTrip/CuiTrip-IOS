  
//
//  TPPayModelTest.m
//  TP
//
//  Created by moxin on 2015-06-15 17:32:26 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPPayModel.h"

@interface TPPayModelTest : XCTestCase

@property(nonatomic,strong)TPPayModel* tPPayModel;

@end

@implementation TPPayModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPPayModel = [TPPayModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPPayModel cancel];
    self.tPPayModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPPayModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPPayModel* tPPayModel = (TPPayModel* )model;
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

