//
//  CommentsTableViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "ServerManager.h"
#import "CommentTableViewCell.h"
#import "Comment.h"
#import "User.h"
#import "UserManager.h"
#import "UIAlertController+ShowAlert.h"

@interface CommentsTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

#define REUSE_ID @"commentCell"
@end

@implementation CommentsTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Apartment *selectedApartment = [UserManager sharedInstance].selectedApartment;
    NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
    
    if (![[ServerManager sharedInstance] isApartment:selectedApartment stillPresentInContext:context]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The selected apartment doesn't exist anymore"
                             inViewController:self
                                  withHandler:^() {
                                      [self.navigationController popToRootViewControllerAnimated:YES];
                                  }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *newCommentButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"New Comment"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(newCommentButtonTouchDown)];
    
    self.navigationItem.rightBarButtonItem = newCommentButton;
    
    NSError *error;
    [[self fetchedResultsController] performFetch:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comment"
                                              inManagedObjectContext:context];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    
    Apartment *apartment = [UserManager sharedInstance].selectedApartment;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"apartment = %@", apartment];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:context
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:nil];
    
    [fetchRequest setEntity:entity];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_ID forIndexPath:indexPath];
    
    Comment *comment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Configure the cell...
    
    
    [cell configureCellWithAuthor:comment.author.username andContent:comment.content];
    
    return cell;
}

#pragma mark - Controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
        break; }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)newCommentButtonTouchDown {
    UIViewController *newCommentViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                             bundle:[NSBundle mainBundle]]
                                                   instantiateViewControllerWithIdentifier:@"newCommentViewController"];
    
    [self presentViewController:newCommentViewController animated:YES completion:nil];
}

@end
