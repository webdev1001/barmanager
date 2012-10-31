//
//  AddBarViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 10/30/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "AddBarViewController.h"

@interface AddBarViewController ()

@end

@implementation AddBarViewController

@synthesize manager, lastLocation, barTextField, barButtonItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.manager.delegate = self;
    self.manager.distanceFilter = 100.0f;
    
    [self.manager startUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Hide keyboard on view press
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBar:(id)sender
{
    barButtonItem.enabled = NO;
    
    Bar *bar = [Bar new];
    bar.name = [self.barTextField text];
    bar.latitude = [NSString stringWithFormat:@"%f", self.lastLocation.coordinate.latitude];
    bar.longitude = [NSString stringWithFormat:@"%f", self.lastLocation.coordinate.longitude];
    
    // Post to /api/bars.json
    [[RKObjectManager sharedManager] postObject:bar delegate:self];
    
    [self.manager stopUpdatingLocation];
}

- (void)dismissKeyboard {
    [barTextField resignFirstResponder];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.lastLocation = [locations lastObject];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSArray *resource_path_array = [[objectLoader resourcePath] componentsSeparatedByString:@"?"];
    objectLoader.resourcePath = [resource_path_array objectAtIndex:0];
    
    // When bar has been added, load cities
    if ([objectLoader wasSentToResourcePath:@"/bars.json"]) {
        [City findCityForLocation:self.lastLocation WithDelegate:self];
    } else if ([objectLoader wasSentToResourcePath:@"/cities.json"]) {
        if ( [[objects objectAtIndex:0] isKindOfClass:[City class]] ){
            City *city = [objects objectAtIndex:0];
            
            // Update city (with bars) and return to dashboard view
            [[NSNotificationCenter defaultCenter]
             postNotificationName:BMCityChange
             object:city];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    barButtonItem.enabled = YES;
    
    NSLog(@"Encountered an error: %@", error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fout"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addBar:textField];
    
    return YES;
}

@end
