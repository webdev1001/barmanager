//
//  ViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>

#import "DashboardViewController.h"
#import "LoginViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

@synthesize navController = _navController, dataModel, cityname;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataModel = [DataModel sharedManager];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(cityChange:)
     name:BMCityChange
     object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Gets called when location managers updates location
- (void)cityChange:(NSNotification*)notification
{
    City *city = [notification object];
    [cityname setText:city.name];
    
    [self displayBarsForCity:city];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSArray * resource_path_array = [[objectLoader resourcePath] componentsSeparatedByString:@"?"];
    objectLoader.resourcePath = [resource_path_array objectAtIndex:0];
    
    if ([objectLoader wasSentToResourcePath:@"/bars.json"]) {
        Bar *bar = [objects objectAtIndex:0];
        NSLog(@"Loaded Bar ID #%@ -> Name: %@, Capacity: %@", bar.barId, bar.name, bar.capacity);
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

- (void)displayBarsForCity:(City*)city
{
    for ( UIView *die in [[self view] subviews]) {   // clear out previous label
        if ( die.tag == 2277 ) {
            [die removeFromSuperview];
        }
    }
    NSInteger y = 130;
    for( Bar *user_bar in city.user_bars )
    {
        y += 30;
        UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(20, y, 150, 20)];
        label.text = user_bar.name;
        label.tag = 2277;
        [self.view addSubview:label];
    }
    
    y = 215;
    for( Bar *other_bar in city.other_bars )
    {
        y += 30;
        UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(20, y, 150, 20)];
        label.text = other_bar.name;
        label.tag = 2277;
        [self.view addSubview:label];
    }
}

@end
