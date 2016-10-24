//
//  EditableNewsViewController.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EditableNewsViewController.h"
#import "NewsRepository.h"
#import "Article.h"

@interface EditableNewsViewController ()
#define CELL_IDENTIFIER @"CellId"

@end

@implementation EditableNewsViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    self.tableView.editing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(beginEditing:);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger count = [[NewsRepository sharedInstance].news count];
    if (self.tableView.editing) {
        count++;
    }
    return count;
}

- (IBAction)beginEditing:(id)sender
{
    if(self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (!(indexPath.row >= [[NewsRepository sharedInstance].news count])) {
        cell.imageView.image = ((Article *)[NewsRepository sharedInstance].news[indexPath.row]).image;
        cell.textLabel.text = ((Article *)[NewsRepository sharedInstance].news[indexPath.row]).title;
    } else {
        cell.textLabel.text = @"Add new article";
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[NewsRepository sharedInstance].news removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        UIViewController *newArticleViewController =
        [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
         instantiateViewControllerWithIdentifier:@"newArticle"];
        
        [[self navigationController] pushViewController:newArticleViewController animated:YES];
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.row < [[NewsRepository sharedInstance].news count]) {
        id objectToMove = [NewsRepository sharedInstance].news[fromIndexPath.row];
        [[NewsRepository sharedInstance].news removeObjectAtIndex:fromIndexPath.row];
        [[NewsRepository sharedInstance].news insertObject:objectToMove atIndex:toIndexPath.row];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [[NewsRepository sharedInstance].news count]) {
        return UITableViewCellEditingStyleInsert;
    }
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.row < [[NewsRepository sharedInstance].news count]) {
        return proposedDestinationIndexPath;
    } else {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row - 1
                                  inSection:proposedDestinationIndexPath.section];
    }
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    if (indexPath.row == [[NewsRepository sharedInstance].news count]) {
        return NO;
    }
    return YES;
}


@end
