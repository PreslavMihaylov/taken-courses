//
//  CommentTableViewCell.m
//  13.RentApartments
//
//  Created by Student07 on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithAuthor:(NSString *)author andContent:(NSString *)content {
    self.authorLabel.text = author;
    self.contentTextView.text = content;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
}

@end
