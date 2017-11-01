//
//  AllNewsViewController.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AllNewsViewController.h"
#import "NewsRepository.h"
#import "Article.h"

@interface AllNewsViewController ()
#define CELL_IDENTIFIER @"CellId"

@end

@implementation AllNewsViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NewsRepository sharedInstance] instantiateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    cell.imageView.image = ((Article *)[[NewsRepository sharedInstance].news objectAtIndex:indexPath.row]).image;
    
    cell.textLabel.text = ((Article *)[[NewsRepository sharedInstance].news objectAtIndex:indexPath.row]).title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[NewsRepository sharedInstance].news count];
}

@end
