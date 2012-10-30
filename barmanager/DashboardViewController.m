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

@synthesize navController = _navController, dataModel, cityname, addBarButton, otherBarsTableView, userBarButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataModel = [DataModel sharedManager];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.jpg"]];
    
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
    
    if ( [city.user_bars count] == 0 ){
        [userBarButton setHidden:YES];
        [addBarButton setHidden:NO];
    } else {
        Bar *user_bar = [ city.user_bars objectAtIndex:0];
        [userBarButton setTitle:user_bar.name forState:UIControlStateNormal];
        [userBarButton setHidden:NO];
        
        [addBarButton setHidden:YES];
    }
    
    [self displayBarsForCity:city];
}

- (void)displayBarsForCity:(City*)city
{
    otherBars = city.other_bars;
    [otherBarsTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return otherBars.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherBarCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIFont *textFont = [ UIFont fontWithName: @"Arial" size: 10.0 ];
    cell.textLabel.font  = textFont;
    cell.detailTextLabel.font = textFont;
    
    Bar *other_bar = [otherBars objectAtIndex:[indexPath row]];
    cell.textLabel.text = other_bar.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Capaciteit: %@", other_bar.capacity];
}

@end
