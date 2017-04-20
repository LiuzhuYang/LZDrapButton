//
//  LZDrapButton.h
//  LZDrapButton
//
//  Created by liuzhu on 2017/4/20.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZDrapButton;
@protocol LZDrapButtonDelegate <NSObject>

@required
-(void)pointUp:(LZDrapButton*)sender;
-(void)pointDown:(LZDrapButton*)sender;
-(void)pointLeft:(LZDrapButton*)sender;
-(void)pointRight:(LZDrapButton*)sender;

@end


@interface LZDrapButton : UIView
-(LZDrapButton*)initDrapButtonWithFrame:(CGRect)frame;
@end
