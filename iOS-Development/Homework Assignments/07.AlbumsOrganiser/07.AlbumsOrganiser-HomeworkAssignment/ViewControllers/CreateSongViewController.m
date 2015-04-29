//
//  CreateSongViewController.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "CreateSongViewController.h"
#import "AlbumsRepository.h"
#import "Song.h"

@interface CreateSongViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *createSongButton;

@end

@implementation CreateSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.artistLabel.text = [AlbumsRepository sharedInstance].chosenAlbumForDetails.artist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)titleLabelEditingChanged:(id)sender {
    if (![self.titleLabel.text isEqualToString:@""]) {
        self.createSongButton.enabled = YES;
    } else {
        self.createSongButton.enabled = NO;
    }
}

- (IBAction)createSongButtonTouchDown:(id)sender {
    Song *song = [[Song alloc] init];
    song.title = self.titleLabel.text;
    song.artist = self.artistLabel.text;
    
    [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs addObject:song];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
