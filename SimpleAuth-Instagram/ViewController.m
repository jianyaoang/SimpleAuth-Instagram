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
@property (nonatomic) NSString *accessToken;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    
    if (self.accessToken == nil)
    {
        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary* responseObject, NSError *error) {
            NSString *accessToken = responseObject[@"credentials"][@"token"];
            [userDefaults setObject:accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            
        }];
    }
    else
    {
        NSLog(@"signed in");
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?&access_token=%@",self.accessToken];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//            NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSArray *photos = [responseDictionary valueForKeyPath:@"data.images.standard_resolution.url"];
            NSLog(@"%@", photos);
        }];
        [task resume];
    }
}



@end
