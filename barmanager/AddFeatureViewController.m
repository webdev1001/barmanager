//
//  AddFeatureViewController.m
//  barmanager
//
//  Created by Joshua Jansen on 15-11-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "AddFeatureViewController.h"

@implementation AddFeatureViewController

@synthesize featuresTableView, dataModel, bar, selectedFeature;

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
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]] delegate:self];
}

- (void)buyFeatureForBar:(NSNumber *)barId WithId:(NSNumber *)featureId
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/features/%@/add_to_bar.json", barId, featureId] delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.available_features = tmp.available_features;
        
        [self.featuresTableView reloadData];
    }
    
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/features/%@/add_to_bar.json", [self.bar barId], [self.selectedFeature featureId]]]) {
        [self.navigationController popViewControllerAnimated:YES];
        
        self.selectedFeature = nil;
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
    // Feature collection view
    if ( [tableView tag] == 0 ){
        return [self.bar.available_features count];
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[featuresTableView dequeueReusableCellWithIdentifier:@"AddFeatureCell" forIndexPath:indexPath];
    
    Feature *feature = [self.bar.available_features objectAtIndex:[indexPath item]];
    
    cell.imageView.image = [UIImage imageNamed:[feature icon]];
    cell.textLabel.text = [feature name];
    cell.detailTextLabel.text = [feature description];
    
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

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feature *feature = [self.bar.available_features objectAtIndex:[indexPath item]];
    self.selectedFeature = feature;
    
    UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Weet je zeker dat je deze feature wilt kopen?"
						  message:[feature name]
						  delegate:self
						  cancelButtonTitle:@"Nee"
						  otherButtonTitles:@"Koop!", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Koop has been pressed
    if ( buttonIndex == 1 ) {
        [self buyFeatureForBar:[self.bar barId] WithId:[self.selectedFeature featureId]];
    }
}

//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    UIFont *textFont = [ UIFont fontWithName: @"Arial" size: 10.0 ];
//    cell.textLabel.font  = textFont;
//    cell.detailTextLabel.font = textFont;
//    
//    [cell.textLabel setFrame:CGRectMake(58, 0, 100, 48)];
//    
//    cell.textLabel.text = @"Zeik natte";
//    cell.detailTextLabel.text = @"KAAS";
//    
//    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [imageButton setFrame:[cell.contentView frame]];
//    [imageButton setFrame:CGRectMake(cell.bounds.size.width - 40, 10, 28, 28)];
//    [imageButton setBackgroundImage:[UIImage imageNamed:@"toevoegen.png"] forState:UIControlStateNormal];
//    [imageButton setTag:1234567];
//    [cell.contentView addSubview:imageButton];
//}

@end
