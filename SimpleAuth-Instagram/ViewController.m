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
@property (strong, nonatomic) IBOutlet UIImageView *instagramImageView;
@property (nonatomic) NSString *accessToken;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSData *data;
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
            
            self.data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:nil];
            
            self.photos = [responseDictionary valueForKeyPath:@"data.images.standard_resolution.url"];
            NSLog(@"%@", self.photos);
        }];
        [task resume];
    }
    
    [self loadInstagramImage];
}

-(void)loadInstagramImage
{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://scontent-b.cdninstagram.com/hphotos-xfp1/t51.2885-15/10483500_1448211665440862_427216422_n.jpg"]];
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.instagramImageView.image = image;
}



@end
