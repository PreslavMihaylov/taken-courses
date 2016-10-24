//
//  ViewController.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "PKMVacationType.h"
#import "PKMVacationInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vacationChosenButtonTouchDown:(id)sender {
    [PKMVacationInfo sharedInstance].chosenType = (VacationType)([sender tag]);
    
    UIViewController *controller = [[UIStoryboard
                                         storyboardWithName:@"Main"
                                         bundle:[NSBundle mainBundle]]
                                        instantiateViewControllerWithIdentifier:@"vacationBook"];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

@end
