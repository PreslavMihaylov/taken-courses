//
//  EntryWebViewController.m
//  16.FlickrFeed
//
//  Created by P. Mihaylov on 5/31/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EntryWebViewController.h"
#import "EntryManager.h"

@interface EntryWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EntryWebViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.webView.frame = self.view.frame;
    [self.webView setScalesPageToFit:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:[EntryManager sharedInstance].selectedEntryContentURL];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setDelegate:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x != 0) {
        [scrollView setContentOffset:CGPointMake(0, offset.y)];
    }
}

@end
