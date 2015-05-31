//
//  EventCollectionReusableView.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventCollectionReusableView.h"

@interface EventCollectionReusableView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation EventCollectionReusableView

-(void)setHeaderTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
