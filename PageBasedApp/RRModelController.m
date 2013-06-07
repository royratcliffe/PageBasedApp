//
//  RRModelController.m
//  PageBasedApp
//
//  Created by Roy Ratcliffe on 06/06/2013.
//  Copyright (c) 2013 Pioneering Software, United Kingdom. All rights reserved.
//

#import "RRModelController.h"

#import "RRDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@implementation RRModelController

- (id)init
{
    self = [super init];
    if (self) {
		// Create the data model.
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		NSArray *monthSymbols = [[dateFormatter monthSymbols] copy];
		[self insertPageObjects:monthSymbols atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [monthSymbols count])]];
		self.viewControllerIdentifier = @"RRDataViewController";
		self.viewControllerPageObjectKey = @"dataObject";
    }
    return self;
}

@end
