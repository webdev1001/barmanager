//
//  AddFeatureViewController.h
//  barmanager
//
//  Created by Joshua Jansen on 15-11-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFeatureViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *featuresTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *featuresTableView;

@end
