//
//  RRModelController.h
//  PageBasedApp
//
//  Created by Roy Ratcliffe on 06/06/2013.
//  Copyright (c) 2013 Pioneering Software, United Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RRDataViewController;

@interface RRModelController : NSObject <UIPageViewControllerDataSource>

- (RRDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(RRDataViewController *)viewController;

@end
