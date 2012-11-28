//
//  BarIndexViewController.h
//  barmanager
//
//  Created by Joshua Jansen on 29-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DataModel.h"
#import "Bar.h"
#import "City.h"
#import "BarViewController.h"

@interface BarIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
    DataModel *dataModel;
    NSArray *user_bars;
    int bar_count;
    IBOutlet UITableView *barsTableView;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *barsTableView;
@property (nonatomic, retain) Bar *bar;
@property (nonatomic, retain) City *city;

@end
