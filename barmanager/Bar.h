//
//  Bar.h
//  barmanager
//
//  Created by Youri van der Lans on 10/19/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BaseBar.h"

@interface Bar : BaseBar

@property (nonatomic, retain) NSArray *city;
@property (nonatomic, retain) NSArray *current_features;
@property (nonatomic, retain) NSArray *available_features;
@property (nonatomic, retain) NSArray *current_expansions;
@property (nonatomic, retain) NSArray *available_expansions;
@property (nonatomic, retain) NSArray *current_enlargements;
@property (nonatomic, retain) NSArray *available_enlargements;

@end
