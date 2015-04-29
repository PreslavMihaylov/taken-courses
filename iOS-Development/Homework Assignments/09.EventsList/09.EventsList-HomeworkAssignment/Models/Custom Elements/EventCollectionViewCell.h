//
//  EventCollectionViewCell.h
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *relatedPersonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
