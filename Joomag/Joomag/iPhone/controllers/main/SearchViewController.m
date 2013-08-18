//
//  SearchViewController.m
//  Joomag
//
//  Created by Anatoli Petrosyants on 2013-08-18.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "SearchViewController.h"
#import "DataHolder.h"
#import "Util.h"

#define TILE_WIDTH_IPHONE 160
#define TILE_HEIGHT_IPHONE 200
#define TILE_WIDTH_IPAD 240
#define TILE_HEIGHT_IPAD 280

@interface SearchViewController () {
    DataHolder *dataHolder;
    NSInteger entriesLength;
    int tileW;
    int tileH;
    int index;
}

@end

@implementation SearchViewController

- (void)loadView {
    [super loadView];
    dataHolder = [[DataHolder alloc] init];
    entriesLength = dataHolder.testData.count;
    
    self.view.backgroundColor = RGBA(64, 64, 65, 1);
    
    //-------------------------------- Top Bar ------------------------------------
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dataHolder.screenWidth, 44)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchTopBarBg.png"]];
    [topView addSubview:backgroundView];
    [topView sendSubviewToBack: backgroundView];
    [self.view addSubview: topView];
    
    //-------------------------- Close Search Botton -------`----------------------
    closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 44)];
    [closeButton addTarget:self  action:@selector(closeSearch) forControlEvents:UIControlEventTouchDown];
    [closeButton setBackgroundImage: [Util imageNamedSmart:@"searchTabBarClose"] forState:UIControlStateNormal];
    [topView addSubview: closeButton];
    
    //------------------------------ Scroll View ----------------------------------
    searchScrollView = [[UIScrollView alloc] init];
    searchScrollView.frame = CGRectMake(70, 46, 884, 640); // TODO
    //searchScrollView.pagingEnabled = YES;
    searchScrollView.backgroundColor = [UIColor clearColor];
    searchScrollView.delegate = self;
    searchScrollView.contentSize = CGSizeMake(884, 4000);
    
    [self.view addSubview: searchScrollView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //NSArray *arrayIPhone = @[ @[@0, @0], @[@1, @0], @[@0, @1], @[@1, @1] ];
        //tileH = 170; tileW = 130;
        //[self setTilesWithArray: arrayIPhone tileWidth: TILE_WIDTH_IPHONE andHeight: TILE_HEIGHT_IPHONE];
    }
    else
    {
        NSArray *arrayIPad = @[ @[@0, @0], @[@1, @0], @[@2, @0], @[@0, @1], @[@1, @1], @[@2, @1] ];
        tileH = 220; tileW = 170;
        [self setTilesWithArray: arrayIPad tileWidth: TILE_WIDTH_IPAD andHeight: TILE_HEIGHT_IPAD];
    }
    
    searchBarView = [[UIView alloc] initWithFrame:CGRectMake(277, 90, 470, 53)];
    UIImageView *searchBarbackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBarBg.png"]];
    [searchBarView addSubview:searchBarbackgroundView];
    [searchBarView sendSubviewToBack: searchBarbackgroundView];
    [self.view addSubview: searchBarView];
    
    CGRect frame = CGRectMake(70, 13, 340, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:17.0];
    textField.placeholder = @"Search Joomag Store";
    textField.backgroundColor = [UIColor clearColor];
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    
    [searchBarView addSubview:textField];
    
    UIButton *closeSearchBarBtn =  [[UIButton alloc] initWithFrame:CGRectMake(470-53, 0, 53, 53)];
    [closeSearchBarBtn addTarget:self  action:@selector(closeSearchBar) forControlEvents:UIControlEventTouchDown];
    [closeSearchBarBtn setBackgroundImage: [Util imageNamedSmart:@"searchBarClose"] forState:UIControlStateNormal];
    
    [searchBarView addSubview: closeSearchBarBtn];
}

// -------------------------------------------------------------------------------
// setTilesWithArray: tileWidth: andHeight:
// Set the images in scroll view
// -------------------------------------------------------------------------------
- (void)setTilesWithArray: (NSArray *)arr tileWidth: (int)width andHeight: (int)height {
    
    int xPosition = 0;
    int yPosition = 10;
    
    for (int i = 1; i < entriesLength; i++) {
        
        //NSLog(@"x: %d y: %d index: %i",xPosition, yPosition, index);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, tileW, tileH)];
        imageView.image = [UIImage imageNamed:@"placeholder.png"];
        imageView.tag = i+1;
        
        [searchScrollView addSubview:imageView];
        
        xPosition = xPosition + tileW + 70;
        NSLog(@"xpos: %i",xPosition);
        
        if(xPosition >= 800){
            xPosition = 0;
            yPosition = yPosition + tileH + 50;
        }
    }
    
    // Set up the content size of the scroll view for IPHONE
    // searchScrollView.contentSize = CGSizeMake(2*660, searchScrollView.frame.size.height); //TODO
}


- (void)closeSearch {
    [UIView transitionWithView: self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated: NO];
}

- (void)closeSearchBar {
    NSLog(@"close search bar");
}

@end
