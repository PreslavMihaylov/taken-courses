//
//  RegisterViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "RegisterViewController.h"
#import "ServerManager.h"
#import "UIAlertController+ShowAlert.h"

@interface RegisterViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (strong, nonatomic) UIView *activeField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchUpInside:(id)sender {
    if ([self areFieldsValidated]) {
        NSManagedObjectContext *context = [[ServerManager sharedInstance] managedObjectContext];
        
        if ([self isValidUserWithUsername:self.usernameTextField.text inContext:context]) {
            NSEntityDescription *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                                         inManagedObjectContext:context];
            
            [newUser setValue:self.usernameTextField.text forKey:@"username"];
            [newUser setValue:self.passwordTextField.text forKey:@"password"];
            [newUser setValue:self.nameTextField.text forKey:@"name"];
            
            [context save:nil];
            
            [UIAlertController showAlertWithTitle:@"Success"
                                       andMessage:@"You have registered successfully."
                                 inViewController:self
                                       withHandler:^(void) {
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            [UIAlertController showAlertWithTitle:@"Error"
                                       andMessage:@"Invalid username. The specified username is already taken."
                                 inViewController:self
                                      withHandler:nil];
        }
        
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) areFieldsValidated {
    NSString *errorMessage;
    
    if ([self.usernameTextField.text length] == 0) {
        errorMessage = @"The username text field cannot be empty.";
    } else if ([self.passwordTextField.text length] == 0) {
        errorMessage = @"The password text field cannot be empty.";
    } else if ([self.nameTextField.text length] == 0) {
        errorMessage = @"The name text field cannot be empty";
    }
    
    if (!errorMessage) {
        return YES;
    } else {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:errorMessage
                             inViewController:self
                                  withHandler:nil];
        return NO;
    }
}

-(BOOL) isValidUserWithUsername:(NSString *)username inContext:(NSManagedObjectContext *)context{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"User" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(username = %@)", username];
    
    [request setPredicate:predicate];
    
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if ([array count] == 0)
    {
        return YES;
    } else {
        NSLog(@"%@", array);
        return NO;
    }
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    CGFloat yPosition = textField.frame.origin.y;
//    
//    
//    [self.scrollView setContentOffset:CGPointMake(0, 100)];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self.scrollView setContentOffset:CGPointMake(0, 0)];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return NO;
//}

#pragma mark - Managing the keyboard

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

# pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}


@end
