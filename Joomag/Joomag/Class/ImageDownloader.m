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
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ImageDownloader ()

@end

@implementation ImageDownloader

#pragma mark

//TODO Create blocks

- (void)startDownloadWithImageView:(UIImageView *)imageView withURL:(NSString *)urlStr andSetIcon: (UIImage *)icon
{
    [imageView setImageWithURL: [NSURL URLWithString: urlStr] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    icon = imageView.image;
    
    // call our delegate and tell it that our icon is ready for display
    if (self.completionHandler)
        self.completionHandler();
    
}

- (void)startDownloadDetailsImageWithImageView:(UIImageView *)imageView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.magazinRecord.magazinDetailsImageURL]];
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
     {
         NSLog(@"details");
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

@end
