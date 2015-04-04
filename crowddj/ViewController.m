//
//  ViewController.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "ViewController.h"
#import "TwitterManager.h"

@interface ViewController (){
    UIButton *playButton;
    UIButton *pauseButton;
    UIButton *refreshButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    _spotifyPlayer = [SpotifyPlayer sharedSpotifyPlayer];
    
    playButton = [[UIButton alloc] init];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    playButton.translatesAutoresizingMaskIntoConstraints = NO;
    playButton.layer.borderColor = [[UIColor blackColor] CGColor];
    playButton.layer.borderWidth = 1.0;
    [playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    pauseButton = [[UIButton alloc] init];
    [pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    pauseButton.layer.borderColor = [[UIColor blackColor] CGColor];
    pauseButton.layer.borderWidth = 1.0;
    [pauseButton addTarget:self action:@selector(pauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    refreshButton = [[UIButton alloc] init];
    [refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
    refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    refreshButton.layer.borderColor = [[UIColor blackColor] CGColor];
    refreshButton.layer.borderWidth = 1.0;
    [refreshButton addTarget:self action:@selector(refreshButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"view will appear");
    
    NSDictionary *bindings = NSDictionaryOfVariableBindings(playButton, pauseButton, refreshButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pauseButton]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[refreshButton]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[playButton(==100)]-10-[pauseButton(==100)]-10-[refreshButton(>=100)]-10-|" options:0 metrics:nil views:bindings]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) playButtonPressed:(id)sender{
    [_spotifyPlayer play];
}

-(IBAction) pauseButtonPressed:(id)sender{
    [_spotifyPlayer pause];
}

- (IBAction) refreshButtonPressed:(id)sender{
    [[TwitterManager sharedTwitterManager] fetchTweetsWithHashtag:@"#crowddj"];
}

@end
