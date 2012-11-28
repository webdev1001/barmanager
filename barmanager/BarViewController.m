//
//  BarViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 11/15/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController ()

@end

@implementation BarViewController

@synthesize barName, cityName, barCapacity, barPopularity;

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
    
    [barName setText:[self.bar name]];
    [cityName setText:[[self.bar.city objectAtIndex:0] name]];
    [barCapacity setText:[[NSString alloc] initWithFormat:@"Bar uitbouwen ( huidige capaciteit: %@ )", [self.bar capacity]]];
    [barPopularity setText:[[NSString alloc] initWithFormat:@" Bar specials ( huidige populariteit: %@ )", [self.bar popularity]]];
}
    
- (void)viewDidAppear:(BOOL)animated
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/expansions.json", [self.bar barId]] delegate:self];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]] delegate:self];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: [NSString stringWithFormat: @"/api/bars/%@/enlargements.json", [self.bar barId]] delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Expansion collection view
    if ( [collectionView tag] == 1 ){
        return [self.bar.current_expansions count];
    }
    
    // Feature collection view
    if ( [collectionView tag] == 2 ){
        return [self.bar.current_features count];
    }
    
    // Enlargement collection view
    if ( [collectionView tag] == 3 ){
        return [self.bar.current_enlargements count];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [collectionView tag] == 1 ){
        identifier = @"ExpansionCell";
        collection = self.bar.current_expansions;
    } else if ( [collectionView tag] == 2 ){
        identifier = @"FeatureCell";
        collection = self.bar.current_features;
    } else if ( [collectionView tag] == 3 ){
        identifier = @"EnlargementCell";
        collection = self.bar.current_enlargements;
    }
    
    BarViewCell *cell = (BarViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Feature *feature = [collection objectAtIndex:[indexPath item]];
    
    cell.imageView.image = [UIImage imageNamed:[feature icon]];
    
    return cell;
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/expansions.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_expansions = tmp.current_expansions;
        
        [self.expansionCollectionView reloadData];
    }
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/features.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_features = tmp.current_features;
        
        [self.featureCollectionView reloadData];
    }
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat: @"/api/bars/%@/enlargements.json", [self.bar barId]]]) {
        Bar *tmp = [objects objectAtIndex:0];
        self.bar.current_enlargements = tmp.current_enlargements;
        
        [self.enlargementCollectionView reloadData];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAvailableFeatures"]) {
        AddFeatureViewController *addFeatureViewController = segue.destinationViewController;
        
        NSLog(@"Passing selected bar (%@) to AddFeatureViewController", self.bar.name);
        addFeatureViewController.bar = self.bar;
    }
}

@end
