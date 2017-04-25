//
//  ViewController.m
//  WFProgressDemo
//
//  Created by happi on 2017/4/21.
//  Copyright © 2017年 xishan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    WFProgress *prog;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    prog = [[WFProgress alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 2)];
    [self.view addSubview:prog];
    [prog setProgress:0.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static CGFloat progress = 0.0;
    progress +=0.25;
    if (progress > 1) {
        progress = 0;
    }
    prog.progress = progress;
}

@end
