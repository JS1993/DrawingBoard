//
//  DrawView.h
//  DrawingBoard
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property(nonatomic,assign)CGFloat lineW;
@property(nonatomic,strong)UIColor* lineC;
@property(nonatomic,strong)UIImage* imageX;

-(void)clear;

-(void)undo;

-(void)easer;

@end
