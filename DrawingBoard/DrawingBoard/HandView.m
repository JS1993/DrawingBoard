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

-(void)setUpGesture{
    
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate=self;
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
    
    CGPoint transP=[pan translationInView:self];
    
    self.imageV.transform=CGAffineTransformTranslate(self.imageV.transform, transP.x, transP.y);
    
    transP=CGPointZero;
    
}


#pragma mark--捏合手势
-(void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    CGFloat scale=pinch.scale;
    
    self.imageV.transform=CGAffineTransformScale(self.imageV.transform, scale, scale);
    
    scale=1.0;
    
}

#pragma mark--旋转手势
-(void)rotate:(UIRotationGestureRecognizer*)rotate{
    
    CGFloat rotation=rotate.rotation;
    
    self.imageV.transform=CGAffineTransformRotate(self.imageV.transform, rotation);
    
    rotation=0;
}

#pragma mark--长按手势
-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    
    
}

#pragma mark--多手势共存 代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}
@end
