// RRUIUtils RRPageModelController.m
//
// Copyright © 2013, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "RRPageModelController.h"

NSString *const kRRPageModelDefaultPageObjectKey = @"pageObject";

@interface RRPageModelController()

@property(strong, nonatomic) id pageObjectsController;
@property(copy, nonatomic) NSString *pageObjectsKeyPath;

- (NSString *)pageObjectKey;

@end

@implementation RRPageModelController

- (NSString *)pageObjectKey
{
	return self.viewControllerPageObjectKey ? self.viewControllerPageObjectKey : kRRPageModelDefaultPageObjectKey;
}

- (NSUInteger)indexOfViewController:(UIViewController *)controller
{
	id pageObject = [controller valueForKey:[self pageObjectKey]];
	return [self.pageObjects indexOfObject:pageObject];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
	NSUInteger count = [self.pageObjects count];
	if (count == 0 || index >= count) return nil;
	UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifier];
	id pageObject = [self.pageObjects objectAtIndex:index];
	[viewController setValue:pageObject forKey:[self pageObjectKey]];
	return viewController;
}

#pragma mark - Page Objects

- (void)observePageObjectsForKeyPath:(NSString *)keyPath ofController:(id)controller
{
	[self.pageObjectsController removeObserver:self forKeyPath:self.pageObjectsKeyPath];
	[self.pageObjectsController = controller addObserver:self forKeyPath:self.pageObjectsKeyPath = keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)dealloc
{
	[self observePageObjectsForKeyPath:nil ofController:nil];
}

- (NSOrderedSet *)pageObjects
{
	return [self.pageObjectsController valueForKeyPath:self.pageObjectsKeyPath];
}

// The page index does not wrap in either direction: forwards or
// backwards. Handle indexing in a way that will allow sub-classes to override
// it if required.

- (NSUInteger)indexBeforeIndex:(NSUInteger)index
{
	if (index == NSNotFound || index == 0) return NSNotFound;
	return index - 1;
}

- (NSUInteger)indexAfterIndex:(NSUInteger)index
{
	if (index == NSNotFound || index + 1 == [self.pageObjects count]) return NSNotFound;
	return index + 1;
}

- (NSArray *)viewControllersForPortraitInterfaceOrientation
{
	// Expression `self.pageViewController.viewControllers[0]` gives the
	// 'current' view controller, or the left-most view controller. This assumes
	// more than zero view controllers.
	return @[self.pageViewController.viewControllers[0]];
}

- (NSArray *)viewControllersForLandscapeInterfaceOrientation
{
	NSArray *viewControllers;
	UIViewController *viewController = self.pageViewController.viewControllers[0];
	NSUInteger indexOfViewController = [self indexOfViewController:viewController];
	if (indexOfViewController % 2 == 0)
		viewControllers = @[viewController, [self pageViewController:self.pageViewController viewControllerAfterViewController:viewController]];
	else
		viewControllers = @[[self pageViewController:self.pageViewController viewControllerBeforeViewController:viewController], viewController];
	return viewControllers;
}

#pragma mark - Page View Controller Data Source

// before…
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:viewController];
	if ((index = [self indexBeforeIndex:index]) == NSNotFound) return nil;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

// after…
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:viewController];
	if ((index = [self indexAfterIndex:index]) == NSNotFound) return nil;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
