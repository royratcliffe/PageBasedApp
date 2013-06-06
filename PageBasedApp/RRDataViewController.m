//
//  RRDataViewController.m
//  PageBasedApp
//
//  Created by Roy Ratcliffe on 06/06/2013.
//  Copyright (c) 2013 Pioneering Software, United Kingdom. All rights reserved.
//

#import "RRDataViewController.h"

@interface RRDataViewController ()

@end

@implementation RRDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
