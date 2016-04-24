//
//  HandView.m
//  DrawingBoard
//
//  Created by  江苏 on 16/4/24.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "HandView.h"

@interface HandView()<UIGestureRecognizerDelegate>



@end

@implementation HandView

-(UIImageView *)imageV{
    
    if (_imageV==nil) {
        
        _imageV=[[UIImageView alloc]initWithFrame:self.bounds];
        
        _imageV.userInteractionEnabled=YES;
        
        [self setUpGesture];
        
        [self addSubview:_imageV];
    }
    return _imageV;
}

-(void)setImageX:(UIImage *)imageX{
    
    _imageX=imageX;
    
    self.imageV.image=imageX;

}

#pragma mark--拦截手势
-(void)panHandle:(UIPanGestureRecognizer*)panHandle{
    
}

#pragma mark--给imageView添加各种手势
-(void)setUpGesture{
    
    UIPanGestureRecognizer* panHandle=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [self addGestureRecognizer:panHandle];
    
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_imageV addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer* pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate=self;
    [_imageV addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer* rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotate:)];
    rotate.delegate=self;
    [_imageV addGestureRecognizer:rotate];
    
    UILongPressGestureRecognizer* longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.delegate=self;
    [_imageV addGestureRecognizer:longPress];
}

#pragma mark--拖动手式
-(void)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint transP=[pan translationInView:self.imageV];
    
    self.imageV.transform=CGAffineTransformTranslate(self.imageV.transform, transP.x, transP.y);
    
    [pan setTranslation:CGPointZero inView:self.imageV];
    
}


#pragma mark--捏合手势
-(void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    CGFloat scale=pinch.scale;
    
    self.imageV.transform=CGAffineTransformScale(self.imageV.transform, scale, scale);
    
    pinch.scale=1.0;
    
}

#pragma mark--旋转手势
-(void)rotate:(UIRotationGestureRecognizer*)rotate{
    
    CGFloat rotation=rotate.rotation;
    
    self.imageV.transform=CGAffineTransformRotate(self.imageV.transform, rotation);
    
    rotate.rotation=0;
}

#pragma mark--长按手势
-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    
    if (longPress.state==UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageV.alpha=0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.imageV.alpha=1;
            } completion:^(BOOL finished) {
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
                
                CGContextRef ctx=UIGraphicsGetCurrentContext();
                
                [self.layer renderInContext:ctx];
                
                UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
                
                if (_HandCompetionBlock) {
                    _HandCompetionBlock(image);
                }
                
                UIGraphicsEndImageContext();
                
                [self removeFromSuperview];
                
            }];
        }];
    }
}

#pragma mark--多手势共存 代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}
@end
