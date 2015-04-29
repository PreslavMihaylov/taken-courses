//
//  FeaturedNewsViewController.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "FeaturedNewsViewController.h"
#import "NewsRepository.h"
#import "Article.h"

@interface FeaturedNewsViewController ()
#define CELL_IDENTIFIER @"CellId"

@property (nonatomic) NSMutableArray *featuredNews;

@end

@implementation FeaturedNewsViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.featuredNews = [[NSMutableArray alloc] init];
    [self filterFeaturedArticlesFromArray:[NewsRepository sharedInstance].news];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    cell.imageView.image = ((Article *)[self.featuredNews objectAtIndex:indexPath.row]).image;
    
    cell.textLabel.text = ((Article *)[self.featuredNews objectAtIndex:indexPath.row]).title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.featuredNews count];
}

-(void) filterFeaturedArticlesFromArray:(NSMutableArray *)array {
    for (int index = 0; index < [array count]; index++) {
        if (((Article *)[array objectAtIndex:index]).isFeatured) {
            [self.featuredNews addObject:[array objectAtIndex:index]];
        }
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

@end
