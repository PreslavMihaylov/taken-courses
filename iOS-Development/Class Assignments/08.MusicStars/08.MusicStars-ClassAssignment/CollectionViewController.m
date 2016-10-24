//
//  CollectionViewController.m
//  08.MusicStars-ClassAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "CollectionViewController.h"
#import "MusicStarCollectionViewCell.h"
#import "MusicStarCollectionReusableView.h"
#import "MusicStarsRepository.h"
#import "MusicStar.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"main";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
     
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [[MusicStarsRepository sharedInstance].maleStars count];
    } else {
        return [[MusicStarsRepository sharedInstance].femaleStars count];
    }
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MusicStarCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        header.headerTitleLabel.text = @"Male Stars";
    } else {
        header.headerTitleLabel.text = @"Female Stars";
    }
    header.headerTitleLabel.textColor = [UIColor redColor];
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicStarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    if (indexPath.section == 0) {
        cell.musicStarImage.image = ((MusicStar *)[MusicStarsRepository sharedInstance].maleStars[indexPath.row]).image;
    } else {
        cell.musicStarImage.image = ((MusicStar *)[MusicStarsRepository sharedInstance].femaleStars[indexPath.row]).image;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [MusicStarsRepository sharedInstance].chosenStarToView = [MusicStarsRepository sharedInstance].maleStars[indexPath.row];
    } else {
        [MusicStarsRepository sharedInstance].chosenStarToView = [MusicStarsRepository sharedInstance].femaleStars[indexPath.row];
    }
}

@end
