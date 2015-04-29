//
//  AlbumDetailsViewController.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AlbumDetailsViewController.h"
#import "AlbumsRepository.h"
#import "Album.h"
#import "Song.h"
#import "SongCell.h"

@interface AlbumDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfSongsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *songsEditButton;

#define SONG_CELL_IDENTIFIER @"SongCell"
#define SIMPLE_CELL_IDENTIFIER @"SimpleCell"

@end

@implementation AlbumDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [AlbumsRepository sharedInstance].chosenAlbumForDetails.title;
    self.numberOfSongsLabel.text = [NSString stringWithFormat:@"%ld",
                                    [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count]];

    [self tableView].editing = NO;
    [self.songsEditButton setTitle:@"Edit" forState:UIControlStateNormal];
    [[self tableView] reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self instantiateDetailsData];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)instantiateDetailsData {
    Album* album = [AlbumsRepository sharedInstance].chosenAlbumForDetails;
    self.artistLabel.text = album.artist;
    self.releaseYearLabel.text = [NSString stringWithFormat:@"%ld", album.releaseYear];
    self.numberOfSongsLabel.text = [NSString stringWithFormat:@"%ld", album.numberOfSongs];
    self.coverImageView.image = album.cover;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count];
    
    if (self.tableView.editing) {
        count++;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.row >= [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count])) {
        SongCell *cell = [tableView dequeueReusableCellWithIdentifier:SONG_CELL_IDENTIFIER];
        if (!cell) {
            cell = [[SongCell alloc] init];
        }
        
        Song *song = (Song *)[[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs objectAtIndex:indexPath.row];
        
        cell.trackNumberLabel.text = [NSString stringWithFormat:@"Track %ld", indexPath.row + 1];
        cell.trackNameLabel.text = song.title;
        cell.artistLabel.text = song.artist;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SIMPLE_CELL_IDENTIFIER];
        if (!cell) {
            cell = [[UITableViewCell alloc] init];
        }
        
        cell.textLabel.text = @"Add new Song";
        
        return cell;
    }
}

/* EDITING METHODS */

- (IBAction)beginEditing:(id)sender
{
    if(self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
        [((UIButton *)sender) setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [((UIButton *)sender) setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count]) {
        return NO;
    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        UIViewController *createSongViewController =
        [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
         instantiateViewControllerWithIdentifier:@"createSong"];
        
        createSongViewController.title = @"Create Song";
        
        [[self navigationController] pushViewController:createSongViewController animated:YES];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.row < [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count]) {
        id objectToMove = [AlbumsRepository sharedInstance].chosenAlbumForDetails.songs[fromIndexPath.row];
        
        [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs removeObjectAtIndex:fromIndexPath.row];
        [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs insertObject:objectToMove atIndex:toIndexPath.row];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count]) {
        return UITableViewCellEditingStyleInsert;
    }
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView
    targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                         toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row < [[AlbumsRepository sharedInstance].chosenAlbumForDetails.songs count]) {
        return proposedDestinationIndexPath;
    } else {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1
                                  inSection:proposedDestinationIndexPath.section];
    }
}

@end
