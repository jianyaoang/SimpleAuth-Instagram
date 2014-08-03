//
//  ViewController.m
//  SimpleAuth-Instagram
//
//  Created by Jian Yao Ang on 8/3/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:@"http://idrawcode.tumblr.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", response);
        
        NSString *responseTest = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"responseTest: %@",responseTest);
    }];
    [task resume];
}



@end
