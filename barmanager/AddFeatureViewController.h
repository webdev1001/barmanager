//
//  AddFeatureViewController.h
//  barmanager
//
//  Created by Joshua Jansen on 15-11-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DataModel.h"
#import "Feature.h"

@interface AddFeatureViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
    DataModel *dataModel;
    IBOutlet UITableView *featuresTableView;
    NSArray *features;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *featuresTableView;

@end
