//
//  ViewController.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIButton *playButton;
    UIButton *pauseButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    playButton = [[UIButton alloc] init];
    [playButton setFrame:CGRectMake(0, 0, 200, 200)];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    playButton.translatesAutoresizingMaskIntoConstraints = NO;
    playButton.layer.borderColor = [[UIColor blackColor] CGColor];
    playButton.layer.borderWidth = 1.0;
    [self.view addSubview:playButton];
    
    pauseButton = [[UIButton alloc] init];
    [pauseButton setFrame:CGRectMake(0, 200, 200, 200)];
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    pauseButton.layer.borderColor = [[UIColor blackColor] CGColor];
    pauseButton.layer.borderWidth = 1.0;
    [self.view addSubview:pauseButton];
    
    /*NSDictionary *bindings = NSDictionaryOfVariableBindings(playButton, pauseButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pausebutton]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[playButton(==50)]-10-[pauseButton]-10-|" options:0 metrics:nil views:bindings]];*/
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
