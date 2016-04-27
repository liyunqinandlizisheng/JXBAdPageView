//
//  XJHttpRequestManager.h
//  LoveXJ
//
//  Created by liyunqin on 14-8-11.
//  Copyright (c) 2014年 liyunqin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJHttpRequestManager : NSObject
@property (nonatomic,strong) NSOperationQueue *queue;
+(XJHttpRequestManager *)shareManager;
-(void)cancelOperationQueue;
@end
