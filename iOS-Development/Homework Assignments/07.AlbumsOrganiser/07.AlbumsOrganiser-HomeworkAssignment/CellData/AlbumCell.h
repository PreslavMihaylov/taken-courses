//
//  AlbumCell.h
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/17/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songCountLabel;

@end
