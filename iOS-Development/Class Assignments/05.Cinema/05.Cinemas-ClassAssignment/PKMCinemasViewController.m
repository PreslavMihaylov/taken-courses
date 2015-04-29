//
//  PKMCinemasViewController.m
//  05.Cinemas-ClassAssignment
//
//  Created by Student07 on 4/6/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMCinemasViewController.h"
#import "PKMCinema.h"

@interface PKMCinemasViewController ()

#define INITIAL_VIEW_X 10
#define INITIAL_VIEW_Y 70
#define INITIAL_VIEW_WIDTH 300
#define INITIAL_VIEW_HEIGHT 200
@property (nonatomic) NSMutableArray *cinemas;

@end

@implementation PKMCinemasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self instantiateCinemas];
    [self renderCinemasToView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)programButtonTouchDown:(id)sender {
    // TODO
    NSLog(@"ID: %d", [sender tag]);
}

- (void) instantiateCinemas {
    self.cinemas = [[NSMutableArray alloc] init];
    
    int moviesCounter = 0;
    for (int index = 0; index < 3; index++) {
        NSString *title = [NSString stringWithFormat:@"Cinema %d", index];
        NSString *address = [NSString stringWithFormat:@"Tsarigradsko shose %d",index];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", index]];
        NSString *workingTime = @"14:00 - 18:00";
        
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        for (int movieIndex = 0; movieIndex < 4; movieIndex++) {
            [movies addObject:[NSString stringWithFormat:@"Movie %d", moviesCounter]];
            moviesCounter++;
        }
        
        PKMCinema *cinema = [[PKMCinema alloc] initWithTitle:title
                                                  andAddress:address
                                                      andImage:image
                                                andWorkingTime:workingTime
                                                     andMovies:movies];
        
        [self.cinemas addObject:cinema];
    }
}

- (void) renderCinemasToView {
    int viewOffset = 20;
    for (int index = 0; index < [self.cinemas count]; index++) {
        UIView *currentView = [[UIView alloc] init];
        
        [currentView setFrame:
         CGRectMake(INITIAL_VIEW_X,
                    INITIAL_VIEW_Y + (200 * index) + viewOffset,
                    INITIAL_VIEW_WIDTH,
                    INITIAL_VIEW_HEIGHT)];
         viewOffset += 20;
         
        currentView.layer.borderColor = [UIColor blackColor].CGColor;
        currentView.layer.borderWidth = 1.0;
        
        // Initialize the image view of the cinema
        UIImageView *cinemaImageView = [[UIImageView alloc] initWithImage:((PKMCinema *)self.cinemas[index]).image];
        [cinemaImageView setFrame:CGRectMake(20, 20, 100, 100)];
        
        [currentView addSubview:cinemaImageView];
        
        // Initialize the label for the title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20,
                                            25 + cinemaImageView.bounds.size.height,
                                            INITIAL_VIEW_WIDTH - 20,
                                            20)];
        
        titleLabel.text = [NSString stringWithFormat:@"Title: %@", ((PKMCinema *)self.cinemas[index]).title];
        
        [currentView addSubview:titleLabel];
        
        // Initialize the label for the address
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20,
                                            25 + cinemaImageView.bounds.size.height + titleLabel.bounds.size.height,
                                            INITIAL_VIEW_WIDTH - 20,
                                            20)];
        
        addressLabel.text = [NSString stringWithFormat:@"Address: %@", ((PKMCinema *)self.cinemas[index]).address];
        
        [currentView addSubview:addressLabel];
        
        // Initialize the label for the working time
        UILabel *workingTimeLabel = [[UILabel alloc] initWithFrame:
                                 CGRectMake(20,
                                            25 +
                                            cinemaImageView.bounds.size.height +
                                            titleLabel.bounds.size.height +
                                            addressLabel.bounds.size.height,
                                            INITIAL_VIEW_WIDTH - 20,
                                            20)];
        
        workingTimeLabel.text = [NSString
                                 stringWithFormat:@"Working time: %@",
                                 ((PKMCinema *)self.cinemas[index]).workingTime];
        
        [currentView addSubview:workingTimeLabel];
        
        // Initialize the button for the program of the cinema
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(programButtonTouchDown:)
         forControlEvents:UIControlEventTouchDown];
        
        [button setTag:index];
        
        [button setTitle:@"Program" forState:UIControlStateNormal];
        button.frame = CGRectMake(200,
                                  45,
                                  60,
                                  40.0);
        
        [currentView addSubview:button];
        [self.view addSubview:currentView];
    }
}

@end
