//
//  RootViewController.m
//  test01
//
//  Created by liyunqin on 16/2/26.
//  Copyright © 2016年 liyunqin. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "XJSyncHttpNetWorkRequest.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 80, 50)];
//    [bu setTitle:@"button" forState:UIControlStateNormal];
//    [bu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [bu addTarget:self action:@selector(clickbu:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bu];
    
    
    [self updateData];
    
}
-(void)updateData
{
    NSString *url = @"http://58.68.243.212/fm/config.json";
    
    [XJSyncHttpNetWorkRequest request:url postDataArray:nil completeBlock:^(NSData *data) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",json);
        NSDictionary *dic = json;
        NSLog(@"%@",dic[@"config"][@"classlist"]);
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)clickbu:(UIButton *)sender
{
    ViewController *view = [[ViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
