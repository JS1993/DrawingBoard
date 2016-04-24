//
//  HandView.h
//  DrawingBoard
//
//  Created by  江苏 on 16/4/24.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandView : UIView

@property(nonatomic,strong)UIImageView* imageV;
@property(nonatomic,strong)UIImage* imageX;

@property(nonatomic,strong) void(^HandCompetionBlock)(UIImage* image);
@property(nonatomic,strong) void (^HaneBeginBlock)();

@end
