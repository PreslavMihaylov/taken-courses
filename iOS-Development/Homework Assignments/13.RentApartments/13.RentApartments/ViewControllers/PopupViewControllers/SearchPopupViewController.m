//
//  SearchPopupViewController.m
//  13.RentApartments
//
//  Created by P. Mihaylov on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "SearchPopupViewController.h"
#import "SearchManager.h"

@interface SearchPopupViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *minimumPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maximumPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property (strong, nonatomic) NSArray *apartmentTypes;

@end

@implementation SearchPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialiseTypePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialiseTypePicker {
    NSArray *types = [NSArray arrayWithObjects:@"Single",@"2 Rooms", @"3 Rooms", nil];
    
    self.apartmentTypes = types;
    
    UIPickerView *typePicker = [[UIPickerView alloc] init];
    typePicker.dataSource = self;
    typePicker.delegate = self;
    self.typeTextField.inputView = typePicker;
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

- (IBAction)submitButtonTouchUpInside:(id)sender {
    [SearchManager sharedInstance].typeCriteria = self.typeTextField.text;
    [SearchManager sharedInstance].locationCriteria = self.locationTextField.text;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    
    [SearchManager sharedInstance].minimumPriceCriteria = [formatter numberFromString:self.minimumPriceTextField.text];
    [SearchManager sharedInstance].maximumPriceCriteria = [formatter numberFromString:self.maximumPriceTextField.text];
    [SearchManager sharedInstance].hasChanged = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate 

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField != self.minimumPriceTextField && textField != self.maximumPriceTextField) {
        return YES;
    }
    
    NSString *validCharacters = @"0123456789.";
    
    if ([validCharacters containsString:string]) {
        return YES;
    } else {
        return NO;
    }
}

@end
