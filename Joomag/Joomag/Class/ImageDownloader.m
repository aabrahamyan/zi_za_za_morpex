//
//  ImageDownloader.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-19.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ImageDownloader.h"
#import "MagazinRecord.h"
#import "UIImageView+AFNetworking.h"

@interface ImageDownloader ()

@end

@implementation ImageDownloader

#pragma mark

//TODO

- (void)startDownloadWithImageView:(UIImageView *)imageView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.magazinRecord.magazinImageURL]];
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         self.magazinRecord.magazinIcon = image;
         
         // call our delegate and tell it that our icon is ready for display
         if (self.completionHandler)
             self.completionHandler();
         
     }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     {
         NSLog(@"ImageDownloader failure");
     }];
}

- (void)startDownloadDetailsImageWithImageView:(UIImageView *)imageView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.magazinRecord.magazinDetailsImageURL]];
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         self.magazinRecord.magazinDetailsIcon = image;
         
         // call our delegate and tell it that our icon is ready for display
         if (self.completionHandler)
             self.completionHandler();
         
     }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     {
         NSLog(@"ImageDownloader Details failure");
     }];
}

- (void)startDownloadTEST:(UIImageView *)imageView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.magazinRecord.magazinDetailsImageURL]];
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         self.magazinRecord.magazinTESTIcon = image;
         
         // call our delegate and tell it that our icon is ready for display
         if (self.completionHandler)
             self.completionHandler();
         
     }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
     {
         NSLog(@"ImageDownloader Details failure");
     }];
}

@end
