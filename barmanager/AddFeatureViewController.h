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
#import "Bar.h"
#import "Feature.h"

@interface AddFeatureViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
    DataModel *dataModel;
    IBOutlet UITableView *featuresTableView;
    NSArray *features;
    
    Bar *bar;
    Feature *selectedFeature;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (nonatomic, strong) IBOutlet UITableView *featuresTableView;

@property (nonatomic, strong) Bar *bar;
@property (nonatomic, strong) Feature *selectedFeature;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
