//
//  ImageChoiceCollectionViewController.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ImageChoiceCollectionViewController.h"
#import "ImageRepository.h"
#import "EventImageCollectionViewCell.h"

@interface ImageChoiceCollectionViewController ()

#define IMAGE_CELL_IDENTIFIER @"ImageCell"
@end

@implementation ImageChoiceCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[ImageRepository sharedInstance] numberOfImages];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IMAGE_CELL_IDENTIFIER forIndexPath:indexPath];
    
    UIImage *chosenImage = [[ImageRepository sharedInstance] getImageAtIndex:indexPath.row];
    [cell setImage:chosenImage];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake((width / 2) - 10, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [ImageRepository sharedInstance].chosenImage = [[ImageRepository sharedInstance] getImageAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
