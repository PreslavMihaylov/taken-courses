//
//  NewCommentViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewCommentViewController.h"
#import "UserManager.h"
#import "ServerManager.h"
#import "Comment.h"
#import "UIAlertController+ShowAlert.h"

@interface NewCommentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *activeField;

@end

@implementation NewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authorTextField.text = [UserManager sharedInstance].loggedUser.username;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchUpInside:(id)sender {
    if ([self areFieldsValidated]) {
        
        NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
        Apartment *selectedApartment = [UserManager sharedInstance].selectedApartment;
        
        if ([[ServerManager sharedInstance] isApartment:selectedApartment stillPresentInContext:context]) {
            Comment *newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                                inManagedObjectContext:context];
            
            
            newComment.author = [UserManager sharedInstance].loggedUser;
            newComment.apartment = [UserManager sharedInstance].selectedApartment;
            newComment.date = [NSDate date];
            newComment.content = self.contentTextView.text;
            
            [context save:nil];
            
            [UIAlertController showAlertWithTitle:@"Success"
                                       andMessage:@"Comment posted successfully"
                                 inViewController:self
                                      withHandler:^() {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                      }];
        } else {
            [UIAlertController showAlertWithTitle:@"Error"
                                       andMessage:@"The selected apartment doesn't exist anymore"
                                 inViewController:self
                                      withHandler:^() {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                      }];
        }
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Validation

- (BOOL)areFieldsValidated {
    if ([self.contentTextView.text isEqualToString:@""]) {
        [UIAlertController showAlertWithTitle:@"Erro" andMessage:@"The content of the comment cannot be empty" inViewController:self withHandler:nil];
        return NO;
    }
    
    return YES;
}

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

# pragma mark - Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.activeField = textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.activeField = nil;
}

@end
