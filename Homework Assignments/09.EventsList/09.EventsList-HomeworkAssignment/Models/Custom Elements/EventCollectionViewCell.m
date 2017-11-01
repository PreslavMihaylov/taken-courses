//
//  EventCollectionViewCell.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventCollectionViewCell.h"

@interface EventCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *relatedPersonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation EventCollectionViewCell

-(void)setEvent:(Event *)event {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.dd.yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:event.date];
    
    self.hoursLabel.text = dateString;
    self.relatedPersonLabel.text = event.relatedPerson;
    self.imageView.image = event.image;
    self.titleLabel.text = event.title;
    self.descriptionLabel.text = event.info;
}

@end
