//
//  BarViewController.h
//  barmanager
//
//  Created by Joshua Jansen on 30-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"
#import "City.h"
#import "Feature.h"
#import "Expansion.h"
#import "Enlargement.h"

@interface BarViewController : UITableViewController <RKObjectLoaderDelegate>
{
    
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Bar *bar;
@property (nonatomic, strong) City *city;
@property (nonatomic, strong) Feature *feature;
@property (nonatomic, strong) Expansion *Expansion;
@property (nonatomic, strong) Enlargement *enlargement;
@property (nonatomic, retain) NSArray *sectionNames;

@end
