//
//  ViewController.m
//  05.Cinemas-ClassAssignment
//
//  Created by Student07 on 4/6/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "PKMCinemasViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic) NSString *loggedUser;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouchDown:(id)sender {
    self.loggedUser = self.usernameTextField.text;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Login"
                                message:@"Successfully logged in."
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UINavigationController *navController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"navigationController"];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

@end
