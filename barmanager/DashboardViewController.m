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

@synthesize navController = _navController, manager, dataModel, cityname, addBarButton;

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

- (IBAction)addBarForCityButton:(id)sender
{
    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.manager.delegate = self;
    self.manager.distanceFilter = 100.0f;
    
    [self.manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    NSLog(@"%f", location.coordinate.latitude);
    NSLog(@"%f", location.coordinate.longitude);
    
    Bar *bar = [Bar new];
    bar.name = @"test";
    bar.cityId = self.dataModel.city_id;
    bar.latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    bar.longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    // POST to /request_token
    [[RKObjectManager sharedManager] postObject:bar delegate:self];
    
    [self.manager stopUpdatingLocation];
}

// Gets called when location managers updates location
- (void)cityChange:(NSNotification*)notification
{
    City *city = [notification object];
    [cityname setText:city.name];
    
    if ( [city.user_bars count] == 0 ){
        [addBarButton setHidden:NO];
    } else {
        [addBarButton setHidden:YES];
    }
    
    [self displayBarsForCity:city];
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
    
    y = 225;
    for( Bar *other_bar in city.other_bars )
    {
        y += 30;
        UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(20, y, 150, 20)];
        label.text = other_bar.name;
        label.tag = 2277;
        [self.view addSubview:label];
    }
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

@end
