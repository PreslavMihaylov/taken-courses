//
//  EventImageCollectionViewCell.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventImageCollectionViewCell.h"

@interface EventImageCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation EventImageCollectionViewCell

-(void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
