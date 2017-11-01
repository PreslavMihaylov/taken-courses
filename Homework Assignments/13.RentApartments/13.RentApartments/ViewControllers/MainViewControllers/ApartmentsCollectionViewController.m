//
//  ApartmentsCollectionViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ApartmentsCollectionViewController.h"
#import "ServerManager.h"
#import "UserManager.h"
#import "ApartmentCollectionViewCell.h"
#import "Apartment.h"
#import "SearchPopupViewController.h"
#import "SearchManager.h"
#import "limits.h"

@interface ApartmentsCollectionViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIPopoverController *searchPopoverController;


#define REUSE_ID @"Cell"
#define MAX_INT @2147483647
@end

@implementation ApartmentsCollectionViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *name = [UserManager sharedInstance].loggedUser.name;
    [self setTitle:[NSString stringWithFormat:@"Hello, %@", name]];
    [[self navigationController] setTitle:[NSString stringWithFormat:@"Hello, %@", name]];
    
    if ([SearchManager sharedInstance].hasChanged) {
        NSString *typeCriteria = [SearchManager sharedInstance].typeCriteria;
        NSNumber *minimumPriceCriteria = [SearchManager sharedInstance].minimumPriceCriteria;
        if (!minimumPriceCriteria) {
            minimumPriceCriteria = @0;
        }
        NSNumber *maximumPriceCriteria = [SearchManager sharedInstance].maximumPriceCriteria;
        if (!maximumPriceCriteria) {
            maximumPriceCriteria = MAX_INT;
        }
        NSString *locationCriteria = [SearchManager sharedInstance].locationCriteria;
        
        NSString *locationCriteriaFormat = @"";
        if (![locationCriteria isEqualToString:@""]) {
            locationCriteriaFormat = [NSString stringWithFormat:@"(location CONTAINS[cd] '%@') AND ", locationCriteria];
        }
        
        NSString *typeCriteriaFormat = @"";
        if (![typeCriteria isEqualToString:@""]) {
            typeCriteriaFormat = [NSString stringWithFormat:@"(type CONTAINS '%@') AND ", typeCriteria];
        }
        
        NSString *predicateFormat = [NSString stringWithFormat:@"%@%@(price >= %@) AND (price <= %@)", typeCriteriaFormat, locationCriteriaFormat, minimumPriceCriteria, maximumPriceCriteria];
        
        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:predicateFormat];
        
        NSFetchRequest *request = [self.fetchedResultsController fetchRequest];
        [request setPredicate:predicate];
        
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        [self.collectionView reloadData];
        
        [SearchManager sharedInstance].hasChanged = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Logout"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(logoutButtonTouchDown)];
    
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    UIBarButtonItem *postAdButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Post Ad"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(postAdButtonTouchDown)];
    
    self.navigationItem.rightBarButtonItem = postAdButton;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:REUSE_ID];
    
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
    
    NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apartment"
                                              inManagedObjectContext:context];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ApartmentCollectionViewCell *cell = (ApartmentCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:@"ApartmentCell"
                                              forIndexPath:indexPath];
    
    
    Apartment *apartment = [self.fetchedResultsController  objectAtIndexPath:indexPath];
    
    UIImage *image = [UIImage imageWithData:apartment.image];
    
    [cell configureApartmentCellWithImage:image
                                  andType:apartment.type
                              andLocation:apartment.location
                                 andPrice:apartment.price];
    
    // [cell setBackgroundColor:[UIColor redColor]];
    // cell..text = [task valueForKey:@"content"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Apartment *selectedApartment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [UserManager sharedInstance].selectedApartment = selectedApartment;
    UIBarButtonItem *backButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((screenWidth / 3) - 10, (screenWidth / 3) + 10);
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UICollectionView *collectionView = self.collectionView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
            break;
        case NSFetchedResultsChangeDelete:
            [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
        break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:nil completion:nil];
}

- (void) postAdButtonTouchDown {
    UINavigationController *newAdController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"newAdController"];
    
    [self presentViewController:newAdController animated:YES completion:nil];
}

- (void)logoutButtonTouchDown {
    [UserManager sharedInstance].loggedUser = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearFiltersButtonActionTriggered:(id)sender {
    
    NSFetchRequest *request = [self.fetchedResultsController fetchRequest];
    [request setPredicate:nil];
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    [self.collectionView reloadData];
    
    [SearchManager sharedInstance].hasChanged = NO;
}


@end
