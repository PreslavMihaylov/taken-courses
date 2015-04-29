//
//  EventDetailsViewController.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "EventsRepository.h"

@interface EventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *relatedPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *innerView;


@end

@implementation EventDetailsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    Event *event = [EventsRepository sharedInstance].chosenEvent;
    
    self.imageView.image = event.image;
    self.titleLabel.text = event.title;
    self.relatedPersonLabel.text = event.relatedPerson;
    self.descriptionTextView.text = event.info;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE d MMM hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:event.date];
    
    self.dateLabel.text = dateString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self setAutoLayoutConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setAutoLayoutConstraints {
    UILabel *title = self.titleLabel;
    UILabel *relatedPerson = self.relatedPersonLabel;
    UILabel *date = self.dateLabel;
    UIImageView *imageView = self.imageView;
    UITextView *info = self.descriptionTextView;
    UIView *innerView = self.innerView;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(title, relatedPerson, date, imageView, info, innerView);
    
    // Inner View constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|[innerView]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[innerView(>=300)]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *innerViewCenterX = [NSLayoutConstraint constraintWithItem:innerView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:innerView.superview
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.f constant:0.f];
    
//    NSLayoutConstraint *innerViewCenterY = [NSLayoutConstraint constraintWithItem:innerView
//                                                                        attribute:NSLayoutAttributeCenterY
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:innerView.superview
//                                                                        attribute:NSLayoutAttributeCenterY
//                                                                       multiplier:1.f constant:0];
//    
//    NSLayoutConstraint *innerViewVerticalSpacingBottom = [NSLayoutConstraint constraintWithItem:innerView
//                                                                        attribute:NSLayoutAttributeBottom
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:info
//                                                                        attribute:NSLayoutAttributeBottom
//                                                                       multiplier:1.f constant:20];
//    
//    NSLayoutConstraint *innerViewVerticalSpacingTop = [NSLayoutConstraint constraintWithItem:innerView
//                                                                                   attribute:NSLayoutAttributeTop
//                                                                                    relatedBy:NSLayoutRelationEqual
//                                                                                     toItem:title
//                                                                                  attribute:NSLayoutAttributeTop
//                                                                                 multiplier:1.f constant:20];
    
    [self.view addConstraint:innerViewCenterX];
    //[self.view addConstraint:innerViewCenterY];
    //[self.view addConstraint:innerViewVerticalSpacingBottom];
    //[self.view addConstraint:innerViewVerticalSpacingTop];
    
    // Title Constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-20-[title(==20)]"
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-(>=20)-[title]-(>=20)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *titleCentered = [NSLayoutConstraint constraintWithItem:title
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:title.superview
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.f constant:0.f];
    
    [self.view addConstraint:titleCentered];
    
    // Related Person Constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[title]-20-[relatedPerson(==20)]"
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-(>=20)-[relatedPerson]-(>=20)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *relatedPersonCentered = [NSLayoutConstraint constraintWithItem:relatedPerson
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:relatedPerson.superview
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.f constant:0.f];
    
    [self.view addConstraint:relatedPersonCentered];
    
    // Image View Constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[relatedPerson]-20-[imageView]"
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-(>=20)-[imageView]-(>=20)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *imageViewCentered = [NSLayoutConstraint constraintWithItem:imageView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:imageView.superview
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.f constant:0.f];
    
    [self.view addConstraint:imageViewCentered];
    
    NSLayoutConstraint *imageViewWidth =[NSLayoutConstraint constraintWithItem:imageView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:imageView.superview
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:1.0/2.0
                                                                  constant:0.0f];
    
    NSLayoutConstraint *imageViewHeight =[NSLayoutConstraint constraintWithItem:imageView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:imageView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:1.0/1.0
                                                                      constant:0.0f];
    
    [self.view addConstraint:imageViewHeight];
    [self.view addConstraint:imageViewWidth];
    
    // Date Label Constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[imageView]-20-[date(==20)]"
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-(>=20)-[date]-(>=20)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *dateCentered = [NSLayoutConstraint constraintWithItem:date
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:date.superview
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.f constant:0.f];
    
    [self.view addConstraint:dateCentered];
    
    // Info Text View Constraints
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[date]-20-[info]"
                               options:0
                               metrics:nil
                               views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-(>=20)-[info]-(>=20)-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:views]];
    
    NSLayoutConstraint *infoCentered = [NSLayoutConstraint constraintWithItem:info
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:info.superview
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1.f constant:0.f];
    
    NSLayoutConstraint *infoWidth =[NSLayoutConstraint constraintWithItem:info
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:info.superview
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:2.0/3.0
                                                                      constant:0.0f];
    
    NSLayoutConstraint *infoVerticalSpacingBottom =[NSLayoutConstraint constraintWithItem:info
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:innerView
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:-8.0f];
    
    [self.view addConstraint:infoCentered];
    [self.view addConstraint:infoWidth];
    [self.view addConstraint:infoVerticalSpacingBottom];
}

@end
