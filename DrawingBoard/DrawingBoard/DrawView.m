//
//  DrawView.m
//  DrawingBoard
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property(nonatomic,assign)CGPoint curP;

@property(nonatomic,assign)CGPoint startP;

@end
@implementation DrawView

-(IBAction)pan:(UIPanGestureRecognizer*)pan{
    
    if (pan.state==UIGestureRecognizerStateBegan) {
        self.startP=[pan locationInView:self];
    }else if(pan.state==UIGestureRecognizerStateChanged){
        self.curP=[pan locationInView:self];
    }else if (pan.state==UIGestureRecognizerStateEnded){
        
    }
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath* path=[UIBezierPath bezierPath];
    
    [path moveToPoint:_startP];
    
    [path addLineToPoint:_curP];
    
    [path stroke];
    
    
}

@end
