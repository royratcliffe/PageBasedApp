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

/**
 * A mutable array implements the indexed page objects. The page object
 * interface implements indexed mutable array accessors.
 */
@property(strong, nonatomic) NSMutableArray *pageObjects;

- (NSString *)pageObjectKey;

@end

@implementation RRPageModelController

- (id)init
{
	self = [super init];
	if (self)
	{
		self.pageObjects = [NSMutableArray array];
	}
	return self;
}

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
	NSUInteger count = [self countOfPageObjects];
	if (count == 0 || index >= count) return nil;
	UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifier];
	id pageObject = self.pageObjects[index];
	[viewController setValue:pageObject forKey:[self pageObjectKey]];
	return viewController;
}

#pragma mark - Page Objects

// indexed accessors

- (NSUInteger)countOfPageObjects
{
	return [self.pageObjects count];
}

- (id)objectInPageObjectsAtIndex:(NSUInteger)index
{
	return [self.pageObjects objectAtIndex:index];
}

- (NSArray *)pageObjectsAtIndexes:(NSIndexSet *)indexes
{
	return [self.pageObjects objectsAtIndexes:indexes];
}

- (void)getPageObjects:(__unsafe_unretained id [])objects range:(NSRange)range
{
	[self.pageObjects getObjects:objects range:range];
}

// mutable indexed accessors

- (void)insertObject:(id)anObject inPageObjectsAtIndex:(NSUInteger)index
{
	[self.pageObjects insertObject:anObject atIndex:index];
}

- (void)insertPageObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
	[self.pageObjects insertObjects:objects atIndexes:indexes];
}

- (void)removeObjectFromPageObjectsAtIndex:(NSUInteger)index
{
	[self.pageObjects removeObjectAtIndex:index];
}

- (void)removePageObjectsAtIndexes:(NSIndexSet *)indexes
{
	[self.pageObjects removeObjectsAtIndexes:indexes];
}

- (void)replaceObjectInPageObjectsAtIndex:(NSUInteger)index withObject:(id)anObject
{
	[self.pageObjects replaceObjectAtIndex:index withObject:anObject];
}

- (void)replacePageObjectsAtIndexes:(NSIndexSet *)indexes withPageObjects:(NSArray *)objects
{
	[self.pageObjects replaceObjectsAtIndexes:indexes withObjects:objects];
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
	if (index == NSNotFound || index + 1 == [self countOfPageObjects]) return NSNotFound;
	return index + 1;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
	  viewControllerBeforeViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:viewController];
	if ((index = [self indexBeforeIndex:index]) == NSNotFound) return nil;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
	   viewControllerAfterViewController:(UIViewController *)viewController
{
	NSUInteger index = [self indexOfViewController:viewController];
	if ((index = [self indexAfterIndex:index]) == NSNotFound) return nil;
	return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
