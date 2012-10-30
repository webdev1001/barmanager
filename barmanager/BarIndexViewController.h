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

@interface BarIndexViewController : UITableViewController <RKObjectLoaderDelegate>
{
    DataModel *dataModel;
    NSArray *user_bars;
    int bar_count;
}

@property (nonatomic, retain) DataModel *dataModel;

@end
