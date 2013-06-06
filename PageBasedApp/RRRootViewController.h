//
//  RRRootViewController.h
//  PageBasedApp
//
//  Created by Roy Ratcliffe on 06/06/2013.
//  Copyright (c) 2013 Pioneering Software, United Kingdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
