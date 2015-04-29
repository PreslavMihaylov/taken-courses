//
//  AlbumCoverChoiceViewController.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AlbumCoverChoiceViewController.h"
#import "AlbumsRepository.h"

@interface AlbumCoverChoiceViewController ()

@end

@implementation AlbumCoverChoiceViewController

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.title = @"Cover Choice";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    [super touchesBegan:touches withEvent:event];
    if ([touch view] == [self.view viewWithTag:1] ||
            [touch view] == [self.view viewWithTag:2] ||
            [touch view] == [self.view viewWithTag:3] ||
            [touch view] == [self.view viewWithTag:4]) {
        
        [AlbumsRepository sharedInstance].chosenCoverForNewAlbum = ((UIImageView *)[touch view]).image;
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

@end
