//
//  MusicStarDetailsViewController.m
//  08.MusicStars-ClassAssignment
//
//  Created by Student07 on 4/21/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "MusicStarDetailsViewController.h"
#import "MusicStarsRepository.h"

@interface MusicStarDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *musicStarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MusicStarDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.musicStarImageView.image = [MusicStarsRepository sharedInstance].chosenStarToView.image;
    self.nameLabel.text = [MusicStarsRepository sharedInstance].chosenStarToView.name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
