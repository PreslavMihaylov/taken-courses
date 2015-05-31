//
//  NewEventViewController.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewEventViewController.h"
#import "ImageRepository.h"
#import "EventsRepository.h"
#import "Event.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *relatedPersonTextField;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) UIView *activeField;

@end

@implementation NewEventViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageView.image = [ImageRepository sharedInstance].chosenImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureDatePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchUpInside:(id)sender {
    if ([self areFieldsValidated]) {
        Event *event = [[Event alloc] init];
        event.title = self.titleTextField.text;
        event.info = self.infoTextView.text;
        event.relatedPerson = self.relatedPersonTextField.text;
        event.image = self.imageView.image;
        event.date = self.datePicker.date;
        
        [[EventsRepository sharedInstance] addEvent:event];
        
        [self cancelButtonTouchUpInside:nil];
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) areFieldsValidated {
    NSString *errorMessage;
    
    if ([self.titleTextField.text length] == 0) {
        errorMessage = @"The title field cannot be empty.";
    } else if ([self.infoTextView.text length] == 0) {
        errorMessage = @"The description field cannot be empty.";
    } else if ([self.relatedPersonTextField.text length] == 0) {
        errorMessage = @"The related person field cannot be empty";
    }
    
    if (!errorMessage) {
        return YES;
    } else {
        [self showValidationAlertWithMessage:errorMessage];
        return NO;
    }
}

-(void)showValidationAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)configureDatePicker {
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:30];
    
    NSDate *maxDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMaximumDate:maxDate];
    [self.datePicker setMinimumDate:currentDate];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
