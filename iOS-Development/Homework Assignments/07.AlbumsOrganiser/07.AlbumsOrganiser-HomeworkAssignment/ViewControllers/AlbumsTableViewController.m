//
//  AlbumsTableViewController.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/17/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AlbumsTableViewController.h"
#import "AlbumCell.h"
#import "Album.h"
#import "AlbumsRepository.h"

@interface AlbumsTableViewController ()

#define ALBUM_CELL_IDENTIFIER @"AlbumCell"
@end

@implementation AlbumsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tableView].editing = NO;
    [[self tableView] reloadData];
    self.editButtonItem.title = @"Edit";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AlbumsRepository sharedInstance] instantiateData];
    
    // Configure the edit button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(beginEditing:);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger count = [[AlbumsRepository sharedInstance].albums count];

    if (self.tableView.editing) {
        count++;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.row >= [[AlbumsRepository sharedInstance].albums count])) {
        AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:ALBUM_CELL_IDENTIFIER
                                                                       forIndexPath:indexPath];
        
        Album *album = (Album *)[[AlbumsRepository sharedInstance].albums objectAtIndex:indexPath.row];
        cell.titleLabel.text = album.title;
        cell.artistLabel.text = album.artist;
        cell.songCountLabel.text = [NSString stringWithFormat:@"Songs: %ld", album.numberOfSongs];
        cell.albumCoverImageView.image = album.cover;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newCell" forIndexPath:indexPath];
        
        cell.textLabel.text = @"Add new Album";
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [AlbumsRepository sharedInstance].chosenAlbumForDetails = [AlbumsRepository sharedInstance].albums[indexPath.row];
}

/* EDITING METHODS */

- (IBAction)beginEditing:(id)sender
{
    if(self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
        ((UIBarButtonItem *)sender).title = @"Edit";
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        ((UIBarButtonItem *)sender).title = @"Done";
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[AlbumsRepository sharedInstance].albums removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        UIViewController *createAlbumViewController =
            [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
             instantiateViewControllerWithIdentifier:@"createAlbum"];
        createAlbumViewController.title = @"Create Album";
        
        [[self navigationController] pushViewController:createAlbumViewController animated:YES];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.row < [[AlbumsRepository sharedInstance].albums count]) {
        id objectToMove = [AlbumsRepository sharedInstance].albums[fromIndexPath.row];
        
        [[AlbumsRepository sharedInstance].albums removeObjectAtIndex:fromIndexPath.row];
        [[AlbumsRepository sharedInstance].albums insertObject:objectToMove atIndex:toIndexPath.row];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [[AlbumsRepository sharedInstance].albums count]) {
        return UITableViewCellEditingStyleInsert;
    }
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView
    targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                         toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row < [[AlbumsRepository sharedInstance].albums count]) {
        return proposedDestinationIndexPath;
    } else {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1
                                  inSection:proposedDestinationIndexPath.section];
    }
}

@end
