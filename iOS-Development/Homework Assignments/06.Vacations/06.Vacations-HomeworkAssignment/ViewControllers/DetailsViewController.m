//
//  DetailsViewController.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "DetailsViewController.h"
#import "PKMVacationInfo.h"

@interface DetailsViewController() <BrokerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PKMVacationInfo sharedInstance].delegate = self;
    [self reviewVacation:[PKMVacationInfo sharedInstance].chosenVacation];
    [self initializeDetails];
}

-(void) initializeDetails {
    PKMVacation *chosenVacation = [PKMVacationInfo sharedInstance].chosenVacation;
    self.imageView.image = chosenVacation.image;
    self.titleLabel.text = chosenVacation.name;
    self.locationLabel.text = chosenVacation.location;
    self.descriptionTextView.text = chosenVacation.info;
    self.priceLabel.text = [NSString stringWithFormat:@"%d $", chosenVacation.price];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"Reviews: %d", chosenVacation.reviewCount];
}

- (IBAction)bookButtonTouchDown:(id)sender {
    [[PKMVacationInfo sharedInstance]
     bookVacation:[PKMVacationInfo sharedInstance].chosenVacation];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)attendTodayButtonTouchDown:(id)sender {
    PKMVacation *chosenVacation = [PKMVacationInfo sharedInstance].chosenVacation;
    // Check if the vacation is available for booking today
    if ([self isVacation:chosenVacation openForDate:[NSDate date]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SUCCESS"
                                                        message:@"The vacation is available for booking today. Have a nice trip."
                                                       delegate:self
                                              cancelButtonTitle:@"Yeey"
                                              otherButtonTitles:nil];
        [alert show];
        [self goOnVacation:chosenVacation];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FAILURE"
                                                        message:@"The vacation is not available for booking today. Better luck next time."
                                                       delegate:self
                                              cancelButtonTitle:@"Errgh..."
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void) goOnVacation:(PKMVacation *)vacation {
    for (NSDate *vacationDate in vacation.openDays) {
        if ([self isSameDay:vacationDate otherDay:[NSDate date]]) {
            
            [[PKMVacationInfo sharedInstance] bookVacation:vacation];
            [self.navigationController
             popToRootViewControllerAnimated:YES];
        }
    }
}
- (BOOL) isVacation:(PKMVacation *)vacation openForDate: (NSDate*) dateToCheck {
    
    for (NSDate *vacationDate in vacation.openDays) {
        if ([self isSameDay:vacationDate otherDay:dateToCheck]) {
            return YES;
        }
    }
    return NO;
}

- (void) reviewVacation:(PKMVacation *) vacation {
    vacation.reviewCount++;
}

// Table view delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PKMVacationInfo sharedInstance].chosenVacation.openDays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
    NSString *dateString = [format
                            stringFromDate:
                            (NSDate *)[[PKMVacationInfo sharedInstance].chosenVacation.openDays
                                       objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = dateString;
    return cell;
}

- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end
