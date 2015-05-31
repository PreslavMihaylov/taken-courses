//
//  ApartmentCollectionViewCell.m
//  13.RentApartments
//
//  Created by P.Mihaylov on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ApartmentCollectionViewCell.h"

@interface ApartmentCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ApartmentCollectionViewCell

-(void) configureApartmentCellWithImage:(UIImage *)image
                                andType:(NSString *)type
                            andLocation:(NSString *)location
                               andPrice:(NSNumber *)price {
    self.imageView.image = image;
    self.typeLabel.text = [NSString stringWithFormat:@"Type: %@", type];
    self.locationLabel.text = location;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", [price stringValue]];
}

@end
