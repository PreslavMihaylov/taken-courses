//
//  ViewController.m
//  02.ObjectiveCFundamentals-Homework
//
//  Created by Preslav Mihaylov on 3/26/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Defined constants for the different fixed values
#define SOUP_PRICE 2;
#define MAIN_DISH_PRICE 4.5;
#define DESSERT_PRICE 1.5;
#define COKE_PRICE_PER_LITRE 2;
#define HOME_DELIVERY_TAX 10;
// Note: The Currency quantifiers are not exactly legitimate
#define BGN_CURRENCY_QUANTIFIER 2;
#define DOLLAR_CURRENCY_QUANTIFIER 1.1;

@property NSString* currencySelected;

@property CGFloat totalPrice;

@property (weak, nonatomic) IBOutlet UITextField *soupAmount;

@property (weak, nonatomic) IBOutlet UITextField *mainDishAmount;

@property (weak, nonatomic) IBOutlet UITextField *dessertAmount;

@property (weak, nonatomic) IBOutlet UISlider *cokeSlider;

@property (weak, nonatomic) IBOutlet UISwitch *homeDeliverySwitch;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// The currency selection touch down events
- (IBAction)euroSelectedTouchDown:(id)sender {
    self.currencySelected = @"EUR";
}

- (IBAction)bgnSelectedTouchDown:(id)sender {
    self.currencySelected = @"BGN";
}

- (IBAction)dollarsSelectedTouchDown:(id)sender {
    self.currencySelected = @"$";
}


// The quantity regulation touch down events for the different dishes

// Soup Increase/Decrease touch down events
- (IBAction)soupIncreaseTouchDown:(id)sender {
    NSInteger soupAmount = [self.soupAmount.text integerValue];
    
    if (soupAmount < 10) {
        self.soupAmount.text = [NSString stringWithFormat:@"%ld", soupAmount + 1];
    }
}

- (IBAction)soupDecreaseTouchDown:(id)sender {
    NSInteger soupAmount = [self.soupAmount.text integerValue];
    
    if (soupAmount > 0) {
        self.soupAmount.text = [NSString stringWithFormat:@"%ld", soupAmount - 1];
    }
}

// Main Dish Increase/Decrease touch down events
- (IBAction)mainDishIncreaseTouchDown:(id)sender {
    NSInteger mainDishAmount = [self.mainDishAmount.text integerValue];
    
    if (mainDishAmount < 10) {
        self.mainDishAmount.text = [NSString stringWithFormat:@"%ld", mainDishAmount + 1];
    }
}

- (IBAction)mainDishDecreaseTouchDown:(id)sender {
    NSInteger mainDishAmount = [self.mainDishAmount.text integerValue];
    
    if (mainDishAmount > 0) {
        self.mainDishAmount.text = [NSString stringWithFormat:@"%ld", mainDishAmount - 1];
    }
}

// Dessert Increase/Decrease touch down events
- (IBAction)dessertIncreaseTouchDown:(id)sender {
    NSInteger dessertAmount = [self.dessertAmount.text integerValue];
    
    if (dessertAmount < 10) {
        self.dessertAmount.text = [NSString stringWithFormat:@"%ld", dessertAmount + 1];
    }
}

- (IBAction)dessertDecreaseTouchDown:(id)sender {
    NSInteger dessertAmount = [self.dessertAmount.text integerValue];
    
    if (dessertAmount > 0) {
        self.dessertAmount.text = [NSString stringWithFormat:@"%ld", dessertAmount - 1];
    }
}

// The Calculation button touch down event
- (IBAction)calculateTouchDown:(id)sender {
    CGFloat totalPrice = 0;
    
    totalPrice += [self.soupAmount.text integerValue] * SOUP_PRICE;
    totalPrice += [self.mainDishAmount.text integerValue] * MAIN_DISH_PRICE;
    totalPrice += [self.dessertAmount.text integerValue] * DESSERT_PRICE;
    
    totalPrice += self.cokeSlider.value * COKE_PRICE_PER_LITRE;
    
    if (self.homeDeliverySwitch.isOn) {
        totalPrice += HOME_DELIVERY_TAX;
    }
    
    if (!self.currencySelected) {
        self.currencySelected = @"EUR";
    }
    
    if ([self.currencySelected isEqual:@"BGN"]) {
        totalPrice *= BGN_CURRENCY_QUANTIFIER;
    } else if ([self.currencySelected isEqual:@"$"]) {
        totalPrice *= DOLLAR_CURRENCY_QUANTIFIER;
    }
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"Total Price: %.02f %@", totalPrice, self.currencySelected];
}

@end
