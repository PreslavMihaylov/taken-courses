//
//  EventsListCollectionViewController.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventsListCollectionViewController.h"
#import "EventCollectionViewCell.h"
#import "EventCollectionReusableView.h"
#import "Event.h"
#import "EventsRepository.h"

@interface EventsListCollectionViewController ()

@property (nonatomic) NSMutableDictionary *categorisedEvents;
@property (nonatomic) NSArray *sortedDateKeys;

@property (nonatomic) NSInteger cellDivider;

#define CELL_IDENTIFIER @"CellId"
#define HEADER_IDENTIFIER @"HeaderId"
@end

@implementation EventsListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO];
    
    [self categoriseEvents];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.cellDivider = 2;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.categorisedEvents count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *currentEventsSection = [self.categorisedEvents objectForKey:self.sortedDateKeys[section]];
    
    return [currentEventsSection count];
}

// Generate Header
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    EventCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_IDENTIFIER forIndexPath:indexPath];
    
    NSString *key = self.sortedDateKeys[indexPath.section];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd.yyyy"];
    NSDate *date = [dateFormatter dateFromString:key];
    
    [dateFormatter setDateFormat:@"EEE MMM d"];
    
    [header setHeaderTitle:[dateFormatter stringFromDate:date]];
    
    return header;
}

// Generate Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    NSMutableArray *currentEventsSection = [self.categorisedEvents objectForKey:self.sortedDateKeys[indexPath.section]];
    
    Event *event = (Event *)[currentEventsSection objectAtIndex:indexPath.row];
    
    [cell setEvent:event];
    
    return cell;
}

// Select Item at given indexPath
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *currentEventsSection = [self.categorisedEvents objectForKey:self.sortedDateKeys[indexPath.section]];
    
    [EventsRepository sharedInstance].chosenEvent = (Event *)[currentEventsSection objectAtIndex:indexPath.row];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStylePlain
                                     target:nil
                                     action:nil];
    
    UIViewController *controller =[[self storyboard] instantiateViewControllerWithIdentifier:@"eventDetails"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((width / self.cellDivider) - 10, (width / self.cellDivider) + 10);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionView performBatchUpdates:nil completion:nil];
}

-(void) categoriseEvents {
    self.categorisedEvents = [NSMutableDictionary dictionary];
    
    for (int index = 0; index < [[EventsRepository sharedInstance] numberOfEvents]; index++) {
        Event *event = [[EventsRepository sharedInstance] getEventAtIndex:index];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM.dd.yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:event.date];
        
        if([self.categorisedEvents objectForKey: dateString]){
            NSMutableArray *array = [self.categorisedEvents objectForKey: dateString];
            [array addObject:event];
            [self.categorisedEvents setObject: array forKey:dateString];
        } else{
            NSMutableArray *array = [NSMutableArray arrayWithObject:event];
            [self.categorisedEvents setObject: array forKey:dateString];
        }
    }
    
    self.sortedDateKeys = [[self.categorisedEvents allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (IBAction)LayoutChanged:(id)sender {
    if ([sender tag] == 1) {
        self.cellDivider = 2;
    } else {
        self.cellDivider = 3;
    }
    
    [self.collectionView performBatchUpdates:nil completion:nil];
}

@end
