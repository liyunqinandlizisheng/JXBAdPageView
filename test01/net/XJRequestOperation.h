//
//  XJRequestOperation.h
//  LoveXJ
//
//  Created by liyunqin on 14-8-11.
//  Copyright (c) 2014年 liyunqin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock_t)(NSData *data);
typedef void(^ErrorBlock_t)(NSError *error);

@interface XJRequestOperation : NSOperation
@property(nonatomic,strong) NSURLRequest *urlRequest;
@property (nonatomic,strong)NSMutableData *resultData;
- (id)initWithRequest:(NSURLRequest*)request completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_;
@end
