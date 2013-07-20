//
//  ImageDownloader.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-07-19.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "ImageDownloader.h"
#import "MagazinRecord.h"

#define kAppIconSizeWidth 320
#define kAppIconSizeHeight 568 // TODO

@interface ImageDownloader ()
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@end

@implementation ImageDownloader

#pragma mark

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.magazinRecord.magazinImageURL]];
    
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = conn;
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    //NSLog(@"image: %@",image);
    
    if (image.size.width != kAppIconSizeWidth || image.size.height != kAppIconSizeHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconSizeWidth, kAppIconSizeHeight);
		UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		self.magazinRecord.magazinIcon = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
    }
    else
    {
        self.magazinRecord.magazinIcon = image;
    }
    
    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
    
    // call our delegate and tell it that our icon is ready for display
    if (self.completionHandler)
        self.completionHandler();
}


@end
