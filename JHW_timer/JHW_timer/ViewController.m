//
//  ViewController.m
//  JHW_timer
//
//  Created by JHW on 17/3/9.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"
#import "GCDViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;

@property (weak, nonatomic) IBOutlet UIButton *gcdBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TimerViewController *tVC = [[TimerViewController alloc]init];
    GCDViewController *gVC = [[GCDViewController alloc]init];

    [[_timerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       [self presentViewController:tVC animated:YES completion:^{
           
       }];
    }];
    
    [[_gcdBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self presentViewController:gVC animated:YES completion:^{
            
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
