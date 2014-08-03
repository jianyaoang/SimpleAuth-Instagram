//
//  ViewController.m
//  SimpleAuth-Instagram
//
//  Created by Jian Yao Ang on 8/3/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"

#import <SimpleAuth/SimpleAuth.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [[NSURL alloc] initWithString:@"http://idrawcode.tumblr.com"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@", response);
//        
//        NSString *responseTest = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"responseTest: %@",responseTest);
//    }];
//    [task resume];
    
    //token = 258596838.b40dce4.8b2066716a514e8ab7bdfe375af1d6de
    [SimpleAuth authorize:@"instagram" completion:^(id responseObject, NSError *error) {
        NSLog(@"response: %@", responseObject);
    }];
}



@end
