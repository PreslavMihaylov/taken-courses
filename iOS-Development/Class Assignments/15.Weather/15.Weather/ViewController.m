//
//  ViewController.m
//  15.Weather
//
//  Created by P. Mihaylov on 5/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *weatherDescriptionTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sofiaButtonTouchUpInside:(id)sender {
    [self getWeatherForCity:@"Sofia" andCountryCode:@"bg"];
}

- (IBAction)londonButtonTouchUpInside:(id)sender {
    [self getWeatherForCity:@"London" andCountryCode:@"uk"];
}

- (void)getWeatherForCity:(NSString *)city andCountryCode:(NSString *)countryCode {
    NSString *restServicePath = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@,%@", city, countryCode];
    
    NSURL *serviceUrl = [NSURL URLWithString:restServicePath];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:sessionConfig];
                              
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:serviceUrl
                                        completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *jsonError;
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                               error:&jsonError];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^() {
                                          self.weatherDescriptionTextField.text = json[@"weather"][0][@"description"];
                                      });
                                  }];
    
    [task resume];
    
    // TODO: http://api.openweathermap.org/data/2.5/history/city?id=2885679&type=hour
}

@end
