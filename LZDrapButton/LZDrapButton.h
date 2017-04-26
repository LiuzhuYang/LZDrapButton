//
//  LZDrapButton.h
//  LZDrapButton
//
//  Created by liuzhu on 2017/4/20.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MulticolorView.h"
@class LZDrapButton;
@protocol LZDrapButtonDelegate <NSObject>

@required
-(void)pointUp:(LZDrapButton*)sender;
-(void)pointDown:(LZDrapButton*)sender;
-(void)pointLeft:(LZDrapButton*)sender;
-(void)pointRight:(LZDrapButton*)sender;

@end

@interface LZDrapButton : UIView

/**
 *中间原型滑动按钮滑动的方向
 **/
typedef enum : NSUInteger {
    pointNo,
    pointUp,
    pointDown,
    pointLeft,
    pointRight,
} Direction;

@property(nonatomic,weak)id<LZDrapButtonDelegate>delegate;
@property(nonatomic,strong)NSArray* images;             //滑块顶部图片名称
@property(nonatomic,strong)NSArray* names;              //滑块顶部名称
@property(nonatomic,strong)UIImageView* topImageView;   //顶部图片
@property(nonatomic,strong)UILabel*     topLabel;       //顶部Label
@property(nonatomic,strong)MulticolorView *iMuView;          //呼吸圈
@property(nonatomic,strong)MulticolorView *oMuView;


@property(nonatomic)CGPoint beginPoint;
@property(nonatomic)CGFloat centerX;
@property(nonatomic)CGFloat centerY;


-(LZDrapButton*)initDrapButtonWithFrame:(CGRect)frame;
-(void)addBreathAmbience;
@end
