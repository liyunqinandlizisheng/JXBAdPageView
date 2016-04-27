//
//  XJSyncHttpNetWorkRequest.m
//  LoveXJ
//
//  Created by liyunqin on 14-8-11.
//  Copyright (c) 2014年 liyunqin. All rights reserved.
//

#import "XJSyncHttpNetWorkRequest.h"
#import "XJRequestOperation.h"
#import "XJHttpRequestManager.h"

@interface XJSyncHttpNetWorkRequest ()
{
    CompleteBlock_t completeBlock;
    ErrorBlock_t errorBlock;
}
@property (nonatomic,strong) NSURLRequest *requestt;
@end

@implementation XJSyncHttpNetWorkRequest

+ (id)request:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_{
    XJSyncHttpNetWorkRequest *requst = [[self alloc] initWithRequest:requestUrl postDataArray:postdict completeBlock:compleBlock errorBlock:errorBlock_];
    XJRequestOperation *op = [[XJRequestOperation alloc] initWithRequest:requst.requestt completeBlock:compleBlock errorBlock:errorBlock_];
    [[XJHttpRequestManager shareManager].queue addOperation:op];
    return requst;
}
+ (id)request:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict postImageArray:(NSMutableArray*)imageArray completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_
{
    XJSyncHttpNetWorkRequest *request = [[self alloc] initWithRequest:requestUrl postDataArray:postdict postImageArray:imageArray completeBlock:compleBlock errorBlock:errorBlock_];
    XJRequestOperation *op = [[XJRequestOperation alloc] initWithRequest:request.requestt completeBlock:compleBlock errorBlock:errorBlock_];
    [[XJHttpRequestManager shareManager].queue addOperation:op];
    return request;
}
- (id)initWithRequest:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict postImageArray:(NSMutableArray*)imageArray completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_;
{
    NSString *hyphens = @"--";
    NSString *boundary = @"*****";
    NSString *end = @"\r\n";
    NSMutableData *myRequestData1=[NSMutableData data];
    for (int i = 0; i < imageArray.count; i ++) {
        NSData* data;
        UIImage *image=[imageArray objectAtIndex:i];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"",[NSString stringWithFormat:@"file%d",i+1],[NSString stringWithFormat:@"image%d.png",i+1]];
        [fileTitle appendString:end];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
        [fileTitle appendString:end];
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:data];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //参数的集合的所有key的集合
    NSArray *keys= [postdict allKeys];
    //遍历keys，添加其他参数
    for(int i=0;i<[keys count];i++)
    {
        NSMutableString *body=[[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
        [body appendString:end];
        [body appendString:end];
        //添加字段的值
        [body appendFormat:@"%@",[postdict objectForKey:key]];
        [body appendString:end];
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData1 length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    self.requestt = request;
    self = [super init];
    if (self) {
        completeBlock = [compleBlock copy];
        errorBlock = [errorBlock_ copy];
    }
    return self;
}
- (id)initWithRequest:(NSString *)requestUrl postDataArray:(NSMutableDictionary *)postdict completeBlock:(CompleteBlock_t)compleBlock errorBlock:(ErrorBlock_t)errorBlock_
{
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    if (postdict != nil) {
        [request setHTTPMethod:@"POST"];
        NSMutableString *str = [NSMutableString string];
        NSArray *keyArry = postdict.allKeys;
        for (int i = 0; i < postdict.allValues.count; i ++) {
            NSString *key = [keyArry objectAtIndex:i];
            NSString *value = [postdict valueForKey:key];
            [str appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
            if (i != postdict.allKeys.count - 1) {
                [str appendString:@"&"];
            }
        }
        NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        [request setHTTPBody:postData];
    }
    _requestt = request;
    self = [super init];
    if (self) {
        completeBlock = [completeBlock copy];
        errorBlock = [errorBlock copy];
    }
    
    return self;
}

@end
