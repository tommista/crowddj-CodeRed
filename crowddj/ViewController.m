//
//  ViewController.m
//  crowddj
//
//  Created by Tommy Brown on 4/3/15.
//  Copyright (c) 2015 tommista. All rights reserved.
//

#import "ViewController.h"
#import "TwitterManager.h"
#import "ColorsUtil.h"

@interface ViewController (){
    UIView *bannerView;
    UIView *centerView;
    UIView *textFieldView;
    UIButton *playButton;
    UIButton *pauseButton;
    UIButton *refreshButton;
    UITableView *tableView;
    UIView *bottomView;
    
    UITextField *textField;
    UIButton *hashtagButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"crowddj";
    self.navigationController.navigationBar.barTintColor = [ColorsUtil topColor];
    self.navigationController.navigationBar.tintColor = [ColorsUtil titleTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [ColorsUtil titleTextColor]}];
    self.view.backgroundColor = [ColorsUtil sideBackgroundColor];
    
    _spotifyPlayer = [SpotifyPlayer sharedSpotifyPlayer];
    
    bannerView = [[UIView alloc] init];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerView.backgroundColor = [ColorsUtil topShadowColor];
    [self.view addSubview:bannerView];
    
    centerView = [[UIView alloc] init];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    centerView.backgroundColor = [ColorsUtil centerBackgroundColor];
    [self.view addSubview:centerView];
    
    textFieldView = [[UIView alloc] init];
    textFieldView.translatesAutoresizingMaskIntoConstraints = NO;
    textFieldView.backgroundColor = [ColorsUtil textFieldBackgroundColor];
    [centerView addSubview:textFieldView];
    
    textField = [[UITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder = @"Enter Hashtag Here";
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [textFieldView addSubview:textField];
    
    hashtagButton = [[UIButton alloc] init];
    hashtagButton.translatesAutoresizingMaskIntoConstraints = NO;
    hashtagButton.backgroundColor = [ColorsUtil buttonColors];
    [hashtagButton setTitle:@"Go" forState:UIControlStateNormal];
    [hashtagButton setTitleColor:[ColorsUtil titleTextColor] forState:UIControlStateNormal];
    [textFieldView addSubview:hashtagButton];
    
    tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = [ColorsUtil textFieldBackgroundColor];
    [centerView addSubview:tableView];
    
    bottomView = [[UIView alloc] init];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomView.backgroundColor = [ColorsUtil textFieldBackgroundColor];
    [centerView addSubview:bottomView];
    
    /*playButton = [[UIButton alloc] init];
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
    [self.view addSubview:refreshButton];*/
    
    NSDictionary *bindings = NSDictionaryOfVariableBindings(bannerView, centerView, textFieldView, tableView, bottomView, textField, hashtagButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bannerView]-0-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[centerView]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bannerView(==10)]-0-[centerView(>=200)]-10-|" options:0 metrics:nil views:bindings]];
    
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textFieldView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[tableView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[bottomView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textFieldView(==60)]-10-[tableView]-10-[bottomView(==60)]-10-|" options:0 metrics:nil views:bindings]];
    
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textField]-10-[hashtagButton(==40)]-10-|" options:0 metrics:nil views:bindings]];
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField]-10-|" options:0 metrics:nil views:bindings]];
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[hashtagButton]-10-|" options:0 metrics:nil views:bindings]];
    
    
    
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playButton]-10-|" options:0 metrics:nil views:bindings]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pauseButton]-10-|" options:0 metrics:nil views:bindings]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[refreshButton]-10-|" options:0 metrics:nil views:bindings]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bannerView(==10)]-0-[playButton(==100)]-10-[pauseButton(==100)]-10-[refreshButton(>=100)]-10-|" options:0 metrics:nil views:bindings]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
