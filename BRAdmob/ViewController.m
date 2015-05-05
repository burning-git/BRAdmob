//
//  ViewController.m
//  BRAdmob
//
//  Created by gitBurning on 15/4/14.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "ViewController.h"
#import "BRAdmobView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AdmobInfo * info1=[[AdmobInfo alloc] init];
    info1.defultImage=[UIImage imageNamed:@"6_02"];
    //info1.admobName=@"1";
    
    AdmobInfo * info2=[[AdmobInfo alloc] init];
    info2.defultImage=[UIImage imageNamed:@"6_02"];
    //info2.admobName=@"2";
    
    AdmobInfo * info3=[[AdmobInfo alloc] init];
    info3.defultImage=[UIImage imageNamed:@"sqareImage"];
    // info3.admobName=@"3";
    
    
    AdmobInfo * info4=[[AdmobInfo alloc] init];
    info4.defultImage=[UIImage imageNamed:@"6_02"];
    // info4.admobName=@"4";
    
    AdmobInfo * info5=[[AdmobInfo alloc] init];
    info5.defultImage=[UIImage imageNamed:@"sqareImage"];
    // info5.admobName=@"5";
    
    
    BRAdmobView * view=[[BRAdmobView alloc] initWithFrame:CGRectMake(10, 64, 300, 150) andData:@[info1,info2,info3,info4,info5] andInViewe:self.view];
    [view addPageControlViewWithSize:CGSizeMake(10, 10)];
    view.isAutoScoller=YES;
    [self.view addSubview:view];
    
    
    
    view.admobSelect=^(id info,NSInteger index){
        
        NSLog(@"点击的第%ld个",index);
    };

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
