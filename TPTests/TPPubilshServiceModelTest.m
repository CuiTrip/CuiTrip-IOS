  
//
//  TPPubilshServiceModelTest.m
//  TP
//
//  Created by moxin on 2015-06-11 23:01:53 +0800.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VizzleConfig.h"
#import "TPPubilshServiceModel.h"

@interface TPPubilshServiceModelTest : XCTestCase

@property(nonatomic,strong)TPPubilshServiceModel* tPPubilshServiceModel;

@end

@implementation TPPubilshServiceModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tPPubilshServiceModel = [TPPubilshServiceModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.tPPubilshServiceModel cancel];
    self.tPPubilshServiceModel = nil;
}

- (void)testConnection {
  

    __block BOOL waitingForBlock = YES;
    [self.tPPubilshServiceModel loadWithCompletion:^(VZHTTPModel *model, NSError *error) {
       

        TPPubilshServiceModel* tPPubilshServiceModel = (TPPubilshServiceModel* )model;
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

