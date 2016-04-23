//
//  ViewController.m
//  DrawingBoard
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISlider *lineWSlider;

@property (strong, nonatomic) IBOutlet DrawView *DrawView;


@end

@implementation ViewController

- (IBAction)lineWSlider:(UISlider *)sender{
    
    self.DrawView.lineW=self.lineWSlider.value*20;
    
}
- (IBAction)colorButton:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            self.DrawView.lineC=[UIColor blueColor];
            break;
        case 1:
            self.DrawView.lineC=[UIColor greenColor];
            break;
        case 2:
            self.DrawView.lineC=[UIColor redColor];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineWSlider.minimumValue=0.3;
    self.lineWSlider.maximumValue=1.0;
    
    self.lineWSlider.value=0.15;
     self.DrawView.lineW=self.lineWSlider.value*20;
}


@end
