//
//  NewContactViewController.m
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewContactViewController.h"
#import "PKMContact.h"
#import "PKMUsersRepository.h"

@interface NewContactViewController()
#define INNER_VIEW_INITIAL_Y 132
#define PHONE_NUMBERS_TAG 1
#define INITIAL_PHONE_NUMBER_TEXTFIELD_X 20
#define INITIAL_PHONE_NUMBER_TEXTFIELD_Y 117
#define PHONE_NUMBER_TEXTFIELD_WIDTH 153
#define PHONE_NUMBER_TEXTFIELD_HEIGHT 30
#define INITIAL_SCROLLVIEW_CONTENTSIZE_HEIGHT 200

@property (weak, nonatomic) IBOutlet UITextField *contactNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactDetailsTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *outerView;
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UITextField *initialPhoneNumberTextField;
@property (nonatomic) NSInteger phoneNumberTextFieldToAddY;
@property (nonatomic) NSInteger innerViewCurrentY;
@property (nonatomic) NSInteger textFieldOffset;


@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outerView.contentSize =
    CGSizeMake(self.outerView.bounds.size.width,
               INITIAL_SCROLLVIEW_CONTENTSIZE_HEIGHT);
    
    self.innerViewCurrentY =
        INNER_VIEW_INITIAL_Y;
    self.phoneNumberTextFieldToAddY = INITIAL_PHONE_NUMBER_TEXTFIELD_Y;
    self.textFieldOffset = 10;
}

- (IBAction)createButtonTouchDown:(id)sender {
    NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
    
    for (UIView *obj in [self.outerView subviews]) {
        if ([obj tag] == PHONE_NUMBERS_TAG) {
            [phoneNumbers addObject:((UITextField *)obj).text];
        }
    }
    
    PKMContact *contact = [[PKMContact alloc]
                           initWithName:self.contactNameTextField.text
                           andPhoneNumber:self.initialPhoneNumberTextField.text
                           andImage:DEFAULT_USER_IMAGE
                           andDetails:self.contactDetailsTextField.text];
    
    for (int index = 0; index < [phoneNumbers count]; index++) {
        [contact addPhoneNumber:phoneNumbers[index]];
    }
    
    [[PKMUsersRepository sharedInstance].contacts addObject:contact];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)newPhoneNumberTouchDown:(id)sender {
    UITextField *newPhoneNumberTextField = [[UITextField alloc]
                                            initWithFrame:
                                            CGRectMake(INITIAL_PHONE_NUMBER_TEXTFIELD_X,
                                                       self.phoneNumberTextFieldToAddY + self.textFieldOffset,
                                                       PHONE_NUMBER_TEXTFIELD_WIDTH,
                                                       PHONE_NUMBER_TEXTFIELD_HEIGHT)];
    
    self.phoneNumberTextFieldToAddY += PHONE_NUMBER_TEXTFIELD_HEIGHT;
    self.textFieldOffset += 10;
    
    newPhoneNumberTextField.layer.borderWidth = 0.5;
    newPhoneNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    newPhoneNumberTextField.layer.cornerRadius = 5;
    
    [newPhoneNumberTextField setTag:PHONE_NUMBERS_TAG];
    
    [self.outerView addSubview:newPhoneNumberTextField];
    
    NSLog(@"%ld", self.innerViewCurrentY);
    [self.innerView
     setFrame:
     CGRectMake(self.innerView.bounds.origin.x,
                self.innerViewCurrentY +
                self.textFieldOffset + 10,
                self.innerView.bounds.size.width,
                self.innerView.bounds.size.height)];
    self.innerViewCurrentY += PHONE_NUMBER_TEXTFIELD_HEIGHT;
    
    [self.outerView
     setContentSize:
     CGSizeMake(self.outerView.bounds.size.width,
                INITIAL_SCROLLVIEW_CONTENTSIZE_HEIGHT +
                self.phoneNumberTextFieldToAddY + 200)];
}

@end
