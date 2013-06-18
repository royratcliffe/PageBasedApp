// RRUIUtils RRPageModelController.h
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

#import <UIKit/UIKit.h>

/**
 * Models a static indexed collection of page objects; the collection is
 * _static_ because the model controller does not accommodate dynamic page
 * changes. You can change the page objects, including their ordering, but this
 * requires that you reload any active page view as well as the underlying
 * collection model.
 *
 * The page model controller instantiates view controllers for an indexed
 * collection of abstract page objects. The controller accesses the view
 * controller implementation's page object property using key-value coding.
 */
@interface RRPageModelController : NSObject<UIPageViewControllerDataSource>

@property(copy, nonatomic) NSString *viewControllerIdentifier;
@property(copy, nonatomic) NSString *viewControllerPageObjectKey;

/**
 * Answers the index of the given view controller based on its page object's
 * index within the controller's indexed collection of page objects.
 */
- (NSUInteger)indexOfViewController:(UIViewController *)controller;

/**
 * Instantiates a new view controller for the given index. Sets up the new view
 * controller with the corresponding page object.
 *
 * Turn a page index into a view controller. This requires the identifier of the
 * view controller and a storyboard which can instantiate the view controller
 * using the identifier.
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;

- (NSUInteger)indexBeforeIndex:(NSUInteger)index;
- (NSUInteger)indexAfterIndex:(NSUInteger)index;

//----------------------------------------------------------------- Page Objects

@property(readonly, strong, nonatomic) id pageObjectsController;
@property(readonly, copy, nonatomic) NSString *pageObjectsKeyPath;

- (void)observePageObjectsForKeyPath:(NSString *)keyPath ofController:(id)controller;

/**
 * Answers the observed ordered set of page objects. The data source observes
 * and accesses an ordered set using key-value observation and key-value
 * coding. Typically, you implement the ordered set as mutable but the data
 * source only accesses the set immutably.
 */
@property(readonly, nonatomic) NSOrderedSet *pageObjects;

@end

/**
 * Defines the default key applied to the view controller for accessing its page
 * object. The model controller uses key-value coding to access the view
 * controller property when instantiating a new view controller and when paging
 * through view controllers.
 */
extern NSString *const kRRPageModelDefaultPageObjectKey;
