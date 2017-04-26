//
//  ViewController.m
//  LZDrapButton
//
//  Created by liuzhu on 2017/4/20.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import "ViewController.h"
#import "LZDrapButton.h"
@interface ViewController ()<LZDrapButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    LZDrapButton* drapButton = [[LZDrapButton alloc] initDrapButtonWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2-50, 100, 100)];
    drapButton.images = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"干烧"],[UIImage imageNamed:@"定时"], nil];
    drapButton.delegate = self;
    
    [self.view addSubview:drapButton];
    [drapButton addBreathAmbience];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)pointRight:(LZDrapButton *)sender
{
    NSLog(@"向右");
}

-(void)pointLeft:(LZDrapButton *)sender
{
     NSLog(@"向左");
}

-(void)pointDown:(LZDrapButton *)sender
{
     NSLog(@"向下");
}

-(void)pointUp:(LZDrapButton *)sender
{
     NSLog(@"向上");
}
@end
