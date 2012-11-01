//
//  BarViewController.m
//  barmanager
//
//  Created by Joshua Jansen on 30-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController ()

@end

@implementation BarViewController

@synthesize sectionNames;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    sectionNames = [NSArray arrayWithObjects: @"Expansions", @"Features", @"Enlargement", nil];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]] delegate:self];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/expansions.json", [self.bar barId]] delegate:self];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/enlargements.json", [self.bar barId]] delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_features = tmp.current_features;
        self.bar.available_features = tmp.available_features;
    }
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/expansions.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_expansions = tmp.current_expansions;
        self.bar.available_expansions = tmp.available_expansions;
    }
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/enlargements.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_enlargements = tmp.current_enlargements;
        self.bar.available_enlargements = tmp.available_enlargements;
    }
    
    [self.tableView reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionNames objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section){
        case 0:
            return [self.bar.current_expansions count] + [self.bar.available_expansions count];
            break;
        case 1:
            return [self.bar.current_features count] + [self.bar.available_features count];
            break;
        case 2:
            return [self.bar.current_enlargements count] + [self.bar.available_enlargements count];
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath indexAtPosition:0];
    NSUInteger rowInSection = [indexPath item];
    
    cell.detailTextLabel.text = nil;
    int count_current;
    
    
    for ( UIButton *die in [[cell contentView] subviews]) {
        if ( die.tag == 123456 ) {
            [die removeFromSuperview];
        }
    }
    
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setFrame:[cell.contentView frame]];
    [buyButton setFrame:CGRectMake(cell.bounds.size.width - 50, 0, 40, 40)];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"beers.png"] forState:UIControlStateNormal];
    [buyButton setTitle:nil forState:UIControlStateNormal];
    [buyButton setTag:123456];
    
    if(section == 0)
    {
        count_current = [self.bar.current_expansions count];
        if(rowInSection < count_current)
        {
            Expansion *expansion = [self.bar.current_expansions objectAtIndex:rowInSection];
            cell.textLabel.text = expansion.name;
        }else{
            Expansion *expansion = [self.bar.available_expansions objectAtIndex:rowInSection - count_current];
            cell.textLabel.text = expansion.name;
            [buyButton addTarget:self action:@selector(buyExpansion:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell setTag: [expansion.expansionId intValue]];
            [cell.contentView addSubview:buyButton];
        }
    }
    
    if(section == 1)
    {
        count_current = [self.bar.current_features count];
        if(rowInSection < count_current)
        {
            Feature *feature = [self.bar.current_features objectAtIndex:rowInSection];
            cell.textLabel.text = feature.name;
        }else{
            Feature *feature = [self.bar.available_features objectAtIndex:rowInSection - count_current];
            cell.textLabel.text = feature.name;
            [buyButton addTarget:self action:@selector(buyFeature:) forControlEvents:UIControlEventTouchUpInside];

            [cell setTag: [feature.featureId intValue]];
            [cell.contentView addSubview:buyButton];
        }
    }
    
    if(section == 2)
    {
        count_current = [self.bar.current_enlargements count];
        if(rowInSection < count_current)
        {
            Enlargement *enlagement = [self.bar.current_enlargements objectAtIndex:rowInSection];
            cell.textLabel.text = enlagement.name;
        }else{
            Enlargement *enlargement = [self.bar.available_enlargements objectAtIndex:rowInSection - count_current];
            cell.textLabel.text = enlargement.name;
            [buyButton addTarget:self action:@selector(buyEnlargement:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell setTag: [enlargement.enlargementId intValue]];
            [cell.contentView addSubview:buyButton];
        }
    }
    
}

- (void) buyExpansion:(id)sender
{
    UIButton *but = sender;
    int expansionId = but.superview.superview.tag;
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/expansions/%d/add_to_bar.json", [self.bar barId], expansionId] delegate:self];
    [but removeFromSuperview];
}
- (void) buyFeature:(id)sender
{
    UIButton *but = sender;
    int featureId = but.superview.superview.tag;
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/features/%d/add_to_bar.json", [self.bar barId], featureId] delegate:self];
    [but removeFromSuperview];
}
- (void) buyEnlargement:(id) sender
{
    UIButton *but = sender;
    int enlargementId = but.superview.superview.tag;
    //NSLog(@"/bars/%@/enlargements/%d/add_to_bar.json", [self.bar barId], enlargementId);
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/enlargements/%d/add_to_bar.json", [self.bar barId], enlargementId] delegate:self];
    [but removeFromSuperview];
}

@end
