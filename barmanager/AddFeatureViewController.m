//
//  AddFeatureViewController.m
//  barmanager
//
//  Created by Joshua Jansen on 15-11-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "AddFeatureViewController.h"

@implementation AddFeatureViewController

@synthesize featuresTableView, dataModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self loadFeatures];
    [super viewDidLoad];
}

- (void)loadFeatures
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/api/features.json" delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if ([[objectLoader.URL path] isEqualToString:@"/api/features.json"]) {
        NSLog(@"Loaded Features");
        features = objects;
        
//        available_feature_count = [ features count ];
//        
//        [self.refreshControl endRefreshing];
//        [self.tableView reloadData];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fout"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddFeatureCell" forIndexPath:indexPath];
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
    
    [cell.textLabel setFrame:CGRectMake(58, 0, 100, 48)];
    
    cell.textLabel.text = @"Zeik natte";
    cell.detailTextLabel.text = @"KAAS";
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageButton setFrame:[cell.contentView frame]];
    [imageButton setFrame:CGRectMake(cell.bounds.size.width - 40, 10, 28, 28)];
    [imageButton setBackgroundImage:[UIImage imageNamed:@"toevoegen.png"] forState:UIControlStateNormal];
    [imageButton setTag:1234567];
    [cell.contentView addSubview:imageButton];
}

@end
