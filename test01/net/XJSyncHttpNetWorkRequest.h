//
//  XJSyncHttpNetWorkRequest.h
//  LoveXJ
//
//  Created by liyunqin on 14-8-11.
//  Copyright (c) 2014年 liyunqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompleteBlock_t)(NSData *data);
typedef void(^ErrorBlock_t)(NSError *error);

@interface XJSyncHttpNetWorkRequest : NSObject
@property (nonatomic,strong)NSMutableData *resultData;   //结果数据
@property (nonatomic,strong)NSURLConnection *connection;

+ (id)request:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_;
+ (id)request:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict postImageArray:(NSMutableArray*)imageArray completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_;

//
- (id)initWithRequest:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_;

@end
