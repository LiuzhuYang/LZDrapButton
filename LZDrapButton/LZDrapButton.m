//
//  LZDrapButton.m
//  LZDrapButton
//
//  Created by liuzhu on 2017/4/20.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import "LZDrapButton.h"

@implementation LZDrapButton

-(LZDrapButton*)initDrapButtonWithFrame:(CGRect)frame
{
    if (self=[super init])
    {
        self.frame = frame;
        self.layer.cornerRadius=frame.size.width/2;
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    
}

@end
