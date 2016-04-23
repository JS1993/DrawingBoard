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


-(void)setImageX:(UIImage *)imageX{
    _imageX=imageX;
    
    [self.linePaths addObject:imageX];
    
    [self setNeedsDisplay];
}

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
        
        //创建路径并添加到数组，防止被销毁
        self.path=[[LinePath alloc]init];
        
        self.path.lineWidth=self.lineW;
        
        self.path.lineC=self.lineC;
        
        [self.path moveToPoint:curP];
        
        [self.linePaths addObject:self.path];
        
    }
    
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    //遍历数组绘制所有路径
    for (LinePath* path in self.linePaths) {
        //如果路径是图片，则绘制图片
        if ([path isKindOfClass:[UIImage class]]) {
            
            [(UIImage*)path drawInRect:rect];
            
        }else{
            
            [path.lineC set];
            
            [path stroke];
        }
        
    }
}
/**  清除功能*/
-(void)clear{
    
    [self.linePaths removeAllObjects];
    
    [self setNeedsDisplay];
}

/** 撤销功能*/
-(void)undo{
    
    [self.linePaths removeLastObject];
    
    [self setNeedsDisplay];
    
}

/** 橡皮擦功能 */
-(void)easer{
    
    self.lineC=[UIColor whiteColor];
    
    self.lineW=10;
    
}

@end
