//
//  ViewController.m
//  MHFlashlightDemo
//
//  Created by MacroHong on 9/6/15.
//  Copyright © 2015 MacroHong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MHTorch.h"

@interface ViewController ()
{
    MHTorch *_torch;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _torch = [[MHTorch alloc] init];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(50, 50, 80, 30);
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setTitle:@"开关" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(openFlashlight:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.selected = NO;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openFlashlight:(UIButton *)btn {
    if (btn.selected) {
        [_torch turnTorchOff];
    } else {
        [_torch turnTorchOn];
    }
    btn.selected = !btn.selected;
}

@end
