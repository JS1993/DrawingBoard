//
//  DrawView.m
//  DrawingBoard
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "DrawView.h"
#import "LinePath.h"
@interface DrawView ()

@property(nonatomic,strong)LinePath* path;

@property(nonatomic,strong)NSMutableArray* linePaths;

@end
@implementation DrawView

-(NSMutableArray *)linePaths{
    if (_linePaths==nil) {
        _linePaths=[NSMutableArray array];
    }
    return _linePaths;
}

//路径不一定要在drawRcet中画，但是一定要在drawRect中stoke
-(IBAction)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint curP=[pan locationInView:self];
    
    if (pan.state==UIGestureRecognizerStateBegan) {
        
        self.path=[[LinePath alloc]init];
        
        self.path.lineW=self.lineW;
        self.path.lineC=self.lineC;
        
        [self.path moveToPoint:curP];
        
        [self.linePaths addObject:self.path];
        
    }
    
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    for (LinePath* path in self.linePaths) {
        
        [path.lineC set];
        
        path.lineWidth=path.lineW;
        
        [path stroke];
        
    }
}

@end
