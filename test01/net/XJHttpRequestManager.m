//
//  XJHttpRequestManager.m
//  LoveXJ
//
//  Created by liyunqin on 14-8-11.
//  Copyright (c) 2014年 liyunqin. All rights reserved.
//

#import "XJHttpRequestManager.h"

@implementation XJHttpRequestManager
+(XJHttpRequestManager *)shareManager
{
    static XJHttpRequestManager *httpManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        httpManager = [[XJHttpRequestManager alloc] init];
    });
    return httpManager;
}
-(id)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}
-(void)cancelOperationQueue
{
//    for (NSOperation *op  in self.queue.operations) {
//        [op cancel];
//    }
    
    [self.queue cancelAllOperations];
}
@end
