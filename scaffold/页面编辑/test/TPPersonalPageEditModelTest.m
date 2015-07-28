  
//
//  TPPersonalPageEditModelTest.m
//  TP
//
//  Created by wifigo on 2015-07-28 18:16:49 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPPersonalPageEditModel.h"

@interface TPPersonalPageEditModelTest : XCTestCase

@property(nonatomic,strong)TPPersonalPageEditModel* tPPersonalPageEditModel;

@end

@implementation TPPersonalPageEditModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPPersonalPageEditModel = [TPPersonalPageEditModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPPersonalPageEditModel cancel];
    self.tPPersonalPageEditModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPPersonalPageEditModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPPersonalPageEditModel* tPPersonalPageEditModel = (TPPersonalPageEditModel* )model;
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

