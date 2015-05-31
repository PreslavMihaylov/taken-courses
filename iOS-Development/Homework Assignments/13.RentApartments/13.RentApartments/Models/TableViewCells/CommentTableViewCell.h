//
//  CommentTableViewCell.h
//  13.RentApartments
//
//  Created by Student07 on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

- (void) configureCellWithAuthor:(NSString *)author andContent:(NSString *)content;

@end
