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
#import "SongManager.h"

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
    
    UIView *bottomLabelView;
    UILabel *bottomSongLabel;
    UILabel *bottomArtistLabel;
    UIButton *playPauseButton;
    
    UILabel *hashtagLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //self.navigationController.navigationBar.translucent = NO;
    //self.title = @"crowddj";
    //self.navigationController.navigationBar.barTintColor = [ColorsUtil topColor];
    //self.navigationController.navigationBar.tintColor = [ColorsUtil titleTextColor];
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [ColorsUtil titleTextColor]}];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *toolbarView = [[UIView alloc] init];
    toolbarView.translatesAutoresizingMaskIntoConstraints = NO;
    toolbarView.backgroundColor = [ColorsUtil topColor];
    [self.view addSubview:toolbarView];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    topLabel.textColor = [ColorsUtil titleTextColor];
    topLabel.text = @"CROWD DJ";
    topLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:48];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [toolbarView addSubview:topLabel];
    
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
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Hashtag Here" attributes:@{NSForegroundColorAttributeName: [ColorsUtil displayedTrackColor], NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:24.0]}];
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    textField.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    [textFieldView addSubview:textField];
    
    hashtagButton = [[UIButton alloc] init];
    hashtagButton.translatesAutoresizingMaskIntoConstraints = NO;
    hashtagButton.backgroundColor = [ColorsUtil buttonColors];
    [hashtagButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [hashtagButton setTitle:@"Go" forState:UIControlStateNormal];
    [hashtagButton setTitleColor:[ColorsUtil titleTextColor] forState:UIControlStateNormal];
    [hashtagButton.titleLabel setFont:[UIFont fontWithName:@"DINCondensed-Bold" size:28]];
    [textFieldView addSubview:hashtagButton];
    
    tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = [ColorsUtil textFieldBackgroundColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [centerView addSubview:tableView];
    
    bottomView = [[UIView alloc] init];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomView.backgroundColor = [ColorsUtil textFieldBackgroundColor];
    [centerView addSubview:bottomView];
    
    bottomLabelView = [[UIView alloc] init];
    bottomLabelView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomLabelView.backgroundColor = [UIColor clearColor];
    [bottomView addSubview:bottomLabelView];
    
    playPauseButton = [[UIButton alloc] init];
    playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    playPauseButton.backgroundColor = [UIColor clearColor];
    playPauseButton.titleLabel.font = [UIFont fontWithName:@"icomoon" size:24];
    [playPauseButton setTitle:[NSString stringWithUTF8String:"\ue603"] forState:UIControlStateNormal];
    [playPauseButton setTitleColor:[ColorsUtil displayedTrackColor] forState:UIControlStateNormal];
    [playPauseButton addTarget:self action:@selector(playPausebuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:playPauseButton];
    
    bottomSongLabel = [[UILabel alloc] init];
    bottomSongLabel.translatesAutoresizingMaskIntoConstraints = NO;
    bottomSongLabel.backgroundColor = [UIColor clearColor];
    bottomSongLabel.textColor = [ColorsUtil displayedTrackColor];
    bottomSongLabel.text = @"Song Label";
    bottomSongLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:24];
    //bottomSongLabel.font = [UIFont systemFontOfSize:18];
    [bottomLabelView addSubview:bottomSongLabel];
    
    bottomArtistLabel = [[UILabel alloc] init];
    bottomArtistLabel.translatesAutoresizingMaskIntoConstraints = NO;
    bottomArtistLabel.backgroundColor = [UIColor clearColor];
    bottomArtistLabel.textColor = [ColorsUtil displayedTrackColor];
    bottomArtistLabel.text = @"Artist Label";
    bottomArtistLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];
    //bottomArtistLabel.font = [UIFont systemFontOfSize:14];
    [bottomLabelView addSubview:bottomArtistLabel];
    
    NSDictionary *bindings = NSDictionaryOfVariableBindings(bannerView, centerView, textFieldView, tableView, bottomView, textField, hashtagButton, bottomSongLabel, bottomArtistLabel, bottomLabelView, playPauseButton, toolbarView, topLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolbarView]-0-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bannerView]-0-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[centerView]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[toolbarView(==90)]-0-[bannerView(==10)]-0-[centerView(>=200)]-10-|" options:0 metrics:nil views:bindings]];
    
    [toolbarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topLabel]-0-|" options:0 metrics:nil views:bindings]];
    [toolbarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[topLabel]-0-|" options:0 metrics:nil views:bindings]];
    
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textFieldView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[tableView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[bottomView]-10-|" options:0 metrics:nil views:bindings]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textFieldView(==60)]-10-[tableView]-10-[bottomView(==60)]-10-|" options:0 metrics:nil views:bindings]];
    
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textField]-10-[hashtagButton(==40)]-10-|" options:0 metrics:nil views:bindings]];
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField]-10-|" options:0 metrics:nil views:bindings]];
    [textFieldView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[hashtagButton]-10-|" options:0 metrics:nil views:bindings]];
    
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLabelView]-10-[playPauseButton(==25)]-10-|" options:0 metrics:nil views:bindings]];
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bottomLabelView]-0-|" options:0 metrics:nil views:bindings]];
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[playPauseButton]-0-|" options:0 metrics:nil views:bindings]];
    
    [bottomLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[bottomSongLabel]-10-|" options:0 metrics:nil views:bindings]];
    [bottomLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[bottomArtistLabel]-10-|" options:0 metrics:nil views:bindings]];
    [bottomLabelView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[bottomSongLabel(==25)]-5-[bottomArtistLabel(==20)]-5-|" options:0 metrics:nil views:bindings]];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNewSongNotification:) name:@"NewTrackPlaying" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackAddedNotification:) name:@"TrackAdded" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction) playPausebuttonPressed:(id)sender{
    if(_spotifyPlayer.isPlaying){
        [_spotifyPlayer pause];
        [playPauseButton setTitle:[NSString stringWithUTF8String:"\ue603"] forState:UIControlStateNormal];
        
    } else{
        [_spotifyPlayer play];
        [playPauseButton setTitle:[NSString stringWithUTF8String:"\ue602"] forState:UIControlStateNormal];
    }
}

- (IBAction) goButtonPressed:(id)sender{
    [textField resignFirstResponder];
    
    if(textField.text != nil && ![textField.text isEqualToString:@""]){
        [[TwitterManager sharedTwitterManager] fetchTweetsWithHashtag:textField.text];
        [tableView reloadData];
    }
}

- (void) receiveNewSongNotification:(NSNotification *) notification
{
    NSDictionary *dictionary = notification.userInfo;
    SPTTrack *track = [dictionary objectForKey:@"trackInfo"];
    bottomSongLabel.text = track.name;
    bottomArtistLabel.text = ((SPTArtist*)[track.artists objectAtIndex:0]).name;
    [playPauseButton setTitle:[NSString stringWithUTF8String:"\ue602"] forState:UIControlStateNormal];
    
    /*NSArray *songList = [[SongManager sharedSongManager] getSongList];
    for(int i = 0; i < songList.count; i++){
        SPTTrack *trackFromArray = [songList objectAtIndex:i];
        if([trackFromArray.identifier isEqualToString:track.identifier]){
            [tableView se]
        }
    }*/
}

- (void) trackAddedNotification:(NSNotification *) notification
{
    [tableView reloadData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[SongManager sharedSongManager] getSongList].count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"asfd"];
    cell.backgroundColor = [UIColor clearColor];
    
    NSArray *songList = [[SongManager sharedSongManager] getSongList];
    
    SPTTrack *thisTrack = [songList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = thisTrack.name;
    cell.textLabel.textColor = [ColorsUtil sideBackgroundColor];
    cell.textLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:24];//[UIFont systemFontOfSize:18];
    
    cell.detailTextLabel.text = ((SPTArtist *)[thisTrack.artists objectAtIndex:0]).name;
    cell.detailTextLabel.textColor = [ColorsUtil sideBackgroundColor];
    cell.textLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:18];//[UIFont systemFontOfSize:14];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [ColorsUtil topColor];
    return view;
}

@end
