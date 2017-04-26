//
//  LZDrapButton.m
//  LZDrapButton
//
//  Created by liuzhu on 2017/4/20.
//  Copyright © 2017年 liuzhu. All rights reserved.
//

#import "LZDrapButton.h"

@implementation LZDrapButton
{
    UIImageView* _backgroundImage;
    CGRect _initFrame;
    Direction _pointTo;
    int _viewType;

}

-(LZDrapButton*)initDrapButtonWithFrame:(CGRect)frame
{
    if (self=[super init])
    {
        self.frame = frame;
        _initFrame = frame;
        _pointTo = pointNo;
        _viewType = 1;
        self.layer.cornerRadius=frame.size.width/2;
        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backgroundImage.layer.cornerRadius =frame.size.width/2;
        [_backgroundImage setImage:[UIImage imageNamed:@"主按钮.png"]];
        _backgroundImage.userInteractionEnabled = NO;
        [self addSubview:_backgroundImage];
    }
    return self;
}

-(UIImageView*)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/4, self.bounds.size.height/4, self.bounds.size.width/2, self.bounds.size.height/2)];
        _topImageView.userInteractionEnabled = NO;
        [self addSubview:_topImageView];
        
    }
    return _topImageView;
}

-(UILabel*)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.width/4, self.bounds.size.width, self.bounds.size.width/2)];
        if (!_topImageView) {
            [self topImageView];
        }
        _topLabel.userInteractionEnabled = NO;
        [self addSubview:_topLabel];
    }
    return _topLabel;
}

-(void)setImages:(NSArray *)images
{
    _images = images;
    self.topImageView.image = self.images[_viewType-1];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    self.beginPoint = [[touches anyObject] locationInView:self]; //记录第一个点，以便计算移动距离
    self.centerX = self.center.x;
    self.centerY = self.center.y;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // 计算移动距离，并更新图像的frame
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGPoint superpt =[[touches anyObject] locationInView:self.superview];

    CGRect frame = [self frame];
    if (superpt.y<=(self.centerY+self.centerX-superpt.x) &&
        superpt.y<=((self.centerY/self.centerX)*superpt.x))
    {
        frame.origin.y += pt.y - self.beginPoint.y;
    }
    else if(superpt.y>=(self.centerY+self.centerX-superpt.x) &&
            superpt.y>=((self.centerY/self.centerX)*superpt.x))
    {
        frame.origin.y += pt.y - self.beginPoint.y;
    }
    else if(superpt.x>=(self.centerX+self.centerY-superpt.y) &&
            superpt.x>=((self.centerX/self.centerY)*superpt.y))
    {
        frame.origin.x += pt.x - self.beginPoint.x;
    }
    else if(superpt.x<=(self.centerX+self.centerY-superpt.y) &&
            superpt.x<=((self.centerX/self.centerY)*superpt.y))
    {
        frame.origin.x += pt.x - self.beginPoint.x;
    }
    [self setFrame:frame];
    
    if (self.center.x<=self.superview.bounds.size.width/2-50 &&
        self.center.y>self.superview.bounds.size.height/2-35 &&
        self.center.y<self.superview.bounds.size.height/2+35 )
    {
       _pointTo = pointLeft;
    }
    else if (self.center.x>=self.superview.bounds.size.width/2+50 &&
             self.center.y>self.superview.bounds.size.height/2-35 &&
             self.center.y<self.superview.bounds.size.height/2+35)
    {
        _pointTo = pointRight;
    }
    else if (self.center.y<=self.superview.bounds.size.height/2-50 &&
             self.center.x<self.superview.bounds.size.width/2+35 &&
             self.center.x>self.superview.bounds.size.width/2-35)
    {
        _pointTo = pointUp;
    }
    else if (self.center.y>=self.superview.bounds.size.height/2+50 &&
             self.center.x<self.superview.bounds.size.width/2+35 &&
             self.center.x>self.superview.bounds.size.width/2-35)
    {
        _pointTo = pointDown;
    }
    else
    {
        _pointTo = pointNo;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.frame =_initFrame;
    switch (_pointTo)
    {
        case pointUp:
            if (self.delegate && [self.delegate respondsToSelector:@selector(pointUp:)])
            {
                [self.delegate performSelector:@selector(pointUp:) withObject:self];
            }
            break;
        case pointDown:
            if (self.delegate && [self.delegate respondsToSelector:@selector(pointDown:)])
            {
                [self.delegate performSelector:@selector(pointDown:) withObject:self];
            }
            break;
        case pointLeft:
            if (self.delegate && [self.delegate respondsToSelector:@selector(pointLeft:)])
            {
                [self.delegate performSelector:@selector(pointLeft:) withObject:self];
            }
            _viewType--;
            if (_viewType<=0)
            {
                _viewType = self.images.count;
            }
            break;
        case pointRight:
            if (self.delegate && [self.delegate respondsToSelector:@selector(pointRight:)])
            {
                [self.delegate performSelector:@selector(pointRight:) withObject:self];
            }
            _viewType++;
            if (_viewType>self.images.count)
            {
                _viewType = 1;
            }
            break;
            
        default:
            break;
    }
    self.topImageView.image = self.images[_viewType-1];
    _pointTo = pointNo;
}

-(void)addBreathAmbience
{
    //动画
    self.iMuView=[[MulticolorView alloc] initWithFrame:CGRectMake(self.center.x-70, self.center.y-70, 140, 140)];
    self.oMuView=[[MulticolorView alloc] initWithFrame:CGRectMake(self.iMuView.frame.origin.x-10, self.iMuView.frame.origin.y-20, self.iMuView.frame.size.width+20, self.iMuView.frame.size.height+30)];
    self.iMuView.alpha = 0.2;
    self.oMuView.alpha = 0.2;
    self.iMuView.userInteractionEnabled = NO;
    self.oMuView.userInteractionEnabled = NO;
    [self.superview addSubview:self.iMuView];
    [self.superview addSubview:self.oMuView];
    [self addAnimate];
}

-(void)addAnimate
{
    __weak LZDrapButton* weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        CGAffineTransform newTransform =
        CGAffineTransformScale(weakSelf.iMuView.transform, 2.5, 2.5);
        [weakSelf.iMuView setTransform:newTransform];
        weakSelf.iMuView.center = CGPointMake(weakSelf.center.x, weakSelf.center.y);
        CGAffineTransform newTransform1 =
        CGAffineTransformScale(weakSelf.oMuView.transform, 2.5, 2.5);
        [weakSelf.oMuView setTransform:newTransform1];
        weakSelf.oMuView.center = CGPointMake(weakSelf.center.x, weakSelf.center.y);
    } completion:^(BOOL finished) {
        [weakSelf imageViewControllerBigAnimation];
    }];
}

-(void)imageViewControllerBigAnimation
{
    __weak LZDrapButton* weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        CGAffineTransform newTransform =
        CGAffineTransformScale(weakSelf.iMuView.transform, .4, .4);
        [weakSelf.iMuView setTransform:newTransform];
        weakSelf.iMuView.center = CGPointMake(weakSelf.center.x, weakSelf.center.y);
        CGAffineTransform newTransform1 =
        CGAffineTransformScale(weakSelf.oMuView.transform, .4, .4);
        [weakSelf.oMuView setTransform:newTransform1];
        weakSelf.oMuView.center = CGPointMake(weakSelf.center.x, weakSelf.center.y);
    } completion:^(BOOL finished) {
        [weakSelf addAnimate];
    }];
}

-(void)dealloc
{
    [self.iMuView endAnimation];
    [self.oMuView endAnimation];
}
@end
