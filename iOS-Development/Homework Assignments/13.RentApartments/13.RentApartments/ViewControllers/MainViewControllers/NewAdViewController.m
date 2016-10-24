//
//  NewAdViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/18/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewAdViewController.h"
#import "ServerManager.h"
#import "UIAlertController+ShowAlert.h"
#import "UserManager.h"
#import "User.h"

@interface NewAdViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *apartmentTypes;

@property (strong, nonatomic) UIView *activeField;

@end

@implementation NewAdViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseTypePicker];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initialiseTypePicker {
    NSArray *types = [NSArray arrayWithObjects:@"Single",@"2 Rooms", @"3 Rooms", nil];
    
    self.apartmentTypes = types;
    
    UIPickerView *typePicker = [[UIPickerView alloc] init];
    typePicker.dataSource = self;
    typePicker.delegate = self;
    self.typeTextField.inputView = typePicker;
}

- (IBAction)chooseImageButtonTouchUpInside:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return [self.apartmentTypes count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return self.apartmentTypes[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.typeTextField.text = self.apartmentTypes[row];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)postButtonTouchUpInside:(id)sender {
    if ([self areFieldsValidated]) {
        NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
        
        NSEntityDescription *newApartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment"
                                                                          inManagedObjectContext:context];
        
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *price = [numberFormatter numberFromString:self.priceTextField.text];
        
        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        
        [newApartment setValue:self.typeTextField.text forKey:@"type"];
        [newApartment setValue:self.locationTextField.text forKey:@"location"];
        [newApartment setValue:self.detailsTextView.text forKey:@"details"];
        [newApartment setValue:imageData forKey:@"image"];
        [newApartment setValue:price forKey:@"price"];
        
        User *publisher = [UserManager sharedInstance].loggedUser;
        [newApartment setValue:publisher forKey:@"publisher"];
        
        [context save:nil];
        
        [UIAlertController showAlertWithTitle:@"Success"
                                   andMessage:@"Apartment ad posted successfully"
                             inViewController:self
                                  withHandler:^() {
                                      [self dismissViewControllerAnimated:YES completion:nil];
                                  }];
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Validation

- (BOOL)areFieldsValidated {
    if ([self.typeTextField.text isEqualToString:@""]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The type field cannot be empty"
                             inViewController:self
                                  withHandler:nil];
        return NO;
    } else if ([self.locationTextField.text isEqualToString:@""]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The location field cannot be empty"
                             inViewController:self
                                  withHandler:nil];
        return NO;
    } else if ([self.priceTextField.text isEqualToString:@""]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The price field cannot be empty"
                             inViewController:self
                                  withHandler:nil];
        return NO;
    } else if ([self.detailsTextView.text isEqualToString:@""]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The details field cannot be empty"
                             inViewController:self
                                  withHandler:nil];
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

# pragma mark - Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField != self.priceTextField) {
        return YES;
    }
    
    NSString *validCharacters = @"0123456789.";
    
    if ([validCharacters containsString:string]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

# pragma mark - Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.activeField = textView;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.activeField = nil;
}

@end