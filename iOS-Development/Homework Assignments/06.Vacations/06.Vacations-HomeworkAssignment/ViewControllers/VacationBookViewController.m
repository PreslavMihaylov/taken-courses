//
//  VacationBookViewController.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "VacationBookViewController.h"
#import "PKMVacationInfo.h"

@interface VacationBookViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSInteger currentContentSizeHeight;
@property (nonatomic) NSInteger currentOffsetY;

#define VIEW_INITIAL_WIDTH 300
#define VIEW_INITIAL_HEIGHT 100


@end

@implementation VacationBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentOffsetY = 0;
    self.currentContentSizeHeight = VIEW_INITIAL_HEIGHT;
    [self.scrollView setContentSize:CGSizeMake(VIEW_INITIAL_WIDTH, VIEW_INITIAL_HEIGHT)];
    [self instantiateVacations];
    
}

-(void)instantiateVacations {
    for (PKMVacation *vacation in
         [PKMVacationInfo sharedInstance].availableVacations) {
        if (vacation.type == [PKMVacationInfo sharedInstance].chosenType) {
            UIView *vacationView = [[UIView alloc]
                                    initWithFrame:
                                    CGRectMake(0,
                                               self.currentOffsetY,
                                               VIEW_INITIAL_WIDTH,
                                               VIEW_INITIAL_HEIGHT)];
            
            self.currentOffsetY += VIEW_INITIAL_HEIGHT;
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
            titleLabel.text = vacation.name;
            UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 20, 100, 30)];
            locationLabel.text = vacation.location;
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 30)];
            priceLabel.text = [NSString stringWithFormat:@"$ %d", vacation.price];
            
            UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [detailsButton setTitle:@"Details" forState:UIControlStateNormal];
            [detailsButton setFrame:CGRectMake(160, 50, 50, 30)];
            [detailsButton
             setTag:[[PKMVacationInfo sharedInstance].availableVacations
                     indexOfObject:vacation]];
            
            [detailsButton addTarget:self
                       action:@selector(detailsButtonTouchDown:)
             forControlEvents:UIControlEventTouchDown];
            
            [vacationView addSubview:detailsButton];
            [vacationView addSubview:priceLabel];
            [vacationView addSubview:locationLabel];
            [vacationView addSubview:titleLabel];
            
            vacationView.layer.borderWidth = 1.0;
            [self.scrollView addSubview:vacationView];
            [self.scrollView
             setContentSize:CGSizeMake(VIEW_INITIAL_WIDTH, self.currentContentSizeHeight)];
            
            self.currentContentSizeHeight += VIEW_INITIAL_HEIGHT;
        }
    }
}

-(IBAction)detailsButtonTouchDown:(id)sender {
    [PKMVacationInfo sharedInstance].chosenVacation =
        [[PKMVacationInfo sharedInstance].availableVacations objectAtIndex:[sender tag]];
    
    UIViewController *controller = [[UIStoryboard
                                     storyboardWithName:@"Main"
                                     bundle:[NSBundle mainBundle]]
                                    instantiateViewControllerWithIdentifier:@"detailsView"];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

@end
