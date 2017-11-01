//
//  EntriesTableViewController.m
//  16.FlickrFeed
//
//  Created by P. Mihaylov on 5/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EntriesTableViewController.h"
#import "EntryTableViewCell.h"
#import "ServerManager.h"
#import "Entry.h"
#import "XMLParserDelegate.h"
#import "EntryManager.h"

@interface EntriesTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

#define FLICKR_SERVICE_PATH @"https://api.flickr.com/services/feeds/photos_public.gne"

@end

@implementation EntriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadXMLDataWithServicePath:FLICKR_SERVICE_PATH];
    
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(reloadButtonActionTriggered)];
    
    
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    NSError *error;
    [[self fetchedResultsController] performFetch:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch Results Controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [ServerManager sharedInstance].mainContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry"
                                              inManagedObjectContext:context];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"published" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setEntity:entity];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:context
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.fetchedResultsController sections].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell" forIndexPath:indexPath];
    
    Entry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell setEntry:entry];
    
    
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
        break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    
    NSError *error;
    [[controller managedObjectContext] save:&error];
    
    /*
         Question: Do I need to do the code below in a background queue or does
         it save the changes in background automatically since it 
         is a NSPrivateConcurrencyType ?
     */
    
    [[controller managedObjectContext].parentContext save:&error];
    
    if (error) {
        NSLog(@"error!");
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Entry *entrySelected = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [EntryManager sharedInstance].selectedEntryContentURL = [NSURL URLWithString:entrySelected.original];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *entryWebViewController = [storyboard instantiateViewControllerWithIdentifier:@"entryWebViewController"];
    
    [self.navigationController pushViewController:entryWebViewController animated:YES];
}

- (void)reloadButtonActionTriggered {
    [self loadXMLDataWithServicePath:FLICKR_SERVICE_PATH];
}

- (void)loadXMLDataWithServicePath:(NSString *)servicePath {
    NSURL *serviceUrl = [NSURL URLWithString:servicePath];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionDataTask *xmlTask = [session dataTaskWithURL:serviceUrl
                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                               if (error) {
                                                   NSLog(@"error");
                                               } else {
                                                   NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
                                                   XMLParserDelegate *parserDelegate = [[XMLParserDelegate alloc] init];
                                                   [xmlParser setDelegate:parserDelegate];
                                                   [xmlParser parse];
                                               }
                                           }];
    
    
    [xmlTask resume];
}

@end
