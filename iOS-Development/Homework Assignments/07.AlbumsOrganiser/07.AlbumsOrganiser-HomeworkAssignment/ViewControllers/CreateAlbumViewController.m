//
//  CreateAlbumViewController.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "CreateAlbumViewController.h"
#import "Album.h"
#import "AlbumsRepository.h"

@interface CreateAlbumViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *releaseYearTextField;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *createAlbumButton;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;

@end

@implementation CreateAlbumViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![AlbumsRepository sharedInstance].chosenCoverForNewAlbum) {
        self.coverImageView.image = [UIImage imageNamed:@"image1.jpg"];
        [AlbumsRepository sharedInstance].chosenCoverForNewAlbum = self.coverImageView.image;
    } else {
        self.coverImageView.image = [AlbumsRepository sharedInstance].chosenCoverForNewAlbum;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldEditingChanged:(id)sender {
    if (![self.titleTextField.text isEqualToString:@""] &&
            ![self.releaseYearTextField.text isEqualToString:@""] &&
            ![self.artistTextField.text isEqualToString:@""]) {
        self.createAlbumButton.enabled = YES;
    } else {
        self.createAlbumButton.enabled = NO;
    }
}

- (IBAction)chooseCoverButtonTouchDown:(id)sender {
    UIViewController *coverChoiceViewController =
    [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
     instantiateViewControllerWithIdentifier:@"coverChoice"];
    
    [[self navigationController] pushViewController:coverChoiceViewController animated:YES];
}

- (IBAction)createAlbumButtonTouchDown:(id)sender {
    Album *album = [[Album alloc] init];
    album.title = self.titleTextField.text;
    album.artist = self.artistTextField.text;
    album.releaseYear = [self.releaseYearTextField.text integerValue];
    album.cover = [AlbumsRepository sharedInstance].chosenCoverForNewAlbum;
    
    [[AlbumsRepository sharedInstance].albums addObject:album];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)releaseYearTextFieldValueChanged:(id)sender {
    UITextField *textField = (UITextField *)sender;
    
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    unichar c = [textField.text characterAtIndex:[textField.text length] - 1];
    
    if (![myCharSet characterIsMember:c]) {
        textField.text = [textField.text substringToIndex:[textField.text length] - 1];
    }
}

@end
