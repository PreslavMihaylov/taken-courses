//
//  EntryTableViewCell.m
//  16.FlickrFeed
//
//  Created by P. Mihaylov on 5/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EntryTableViewCell.h"

@interface EntryTableViewCell ()

@property (strong, nonatomic, readwrite) IBOutlet UIImageView *entryImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabel;


@end

@implementation EntryTableViewCell

- (void)setEntry:(Entry *)entry {
    _entry = entry;
    self.titleLabel.text = entry.title;
    self.authorLabel.text = entry.author;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy HH:mm:ss";
    
    self.publishedLabel.text = [formatter stringFromDate:entry.published];
    
    [self setEntryImageWithURL:[NSURL URLWithString:entry.imageURL]];
}

- (void)setEntryImageWithURL:(NSURL *)imageURL {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURLSessionDataTask *imageTask = [session dataTaskWithURL:imageURL
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 dispatch_async(dispatch_get_main_queue(), ^() {
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     self.entryImageView.image = image;
                                                 });
                                             }];
    
    dispatch_queue_t queue = dispatch_queue_create("taskQueue", NULL);
    dispatch_async(queue, ^() {
        [imageTask resume];
    });
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
