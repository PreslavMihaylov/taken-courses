//
//  ApartmentDetailsViewController.m
//  13.RentApartments
//
//  Created by Student07 on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ApartmentDetailsViewController.h"
#import "Apartment.h"
#import "UserManager.h"
#import "ServerManager.h"
#import "CommentTableViewCell.h"
#import "Comment.h"
#import "UIAlertController+ShowAlert.h"

@interface ApartmentDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@end

@implementation ApartmentDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    Apartment *selectedApartment = [UserManager sharedInstance].selectedApartment;
    NSManagedObjectContext *context = [ServerManager sharedInstance].managedObjectContext;
    
    if (![[ServerManager sharedInstance] isApartment:selectedApartment stillPresentInContext:context]) {
        [UIAlertController showAlertWithTitle:@"Error"
                                   andMessage:@"The selected apartment doesn't exist anymore"
                             inViewController:self
                                  withHandler:^() {
                                      [self.navigationController popViewControllerAnimated:YES];
                                  }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureApartmentDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureApartmentDetails {
    Apartment *apartment = [UserManager sharedInstance].selectedApartment;
    
    UIImage *image = [UIImage imageWithData:apartment.image];
    self.imageView.image = image;
    self.typeLabel.text = [NSString stringWithFormat:@"Type: %@", apartment.type];
    self.authorLabel.text = [NSString stringWithFormat:@"Author: %@", apartment.publisher.username];
    self.locationLabel.text = [NSString stringWithFormat:@"Location: %@", apartment.location];
    self.detailsTextView.text = apartment.details;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", apartment.price];
}

@end
