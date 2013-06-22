// RRUIUtils RRPageModelControllerTests.m
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

#import "RRPageModelControllerTests.h"
#import "RRPageModelController.h"

@interface RRPageModelControllerTests()

@property(strong, nonatomic) NSMutableOrderedSet *pageObjects;

@end

@implementation RRPageModelControllerTests

- (void)setUp
{
	self.pageObjects = [NSMutableOrderedSet orderedSet];
}

- (void)tearDown
{
	self.pageObjects = nil;
}

- (void)testKVC
{
	RRPageModelController *controller = [RRPageModelController new];
	[controller observePageObjectsForKeyPath:@"pageObjects" ofController:self];
	STAssertEquals([controller.pageObjects count], (NSUInteger)0, nil);

	// Note that if you alter `self.pageObjects` rather than `[self
	// mutableOrderedSetValueForKey:@"pageObjects"]` then the page model
	// controller cannot observe the change. Ordered sets are not directly
	// observable. Always access their contents using key-value coding
	// accessors.
	NSMutableOrderedSet *pageObjects = [self mutableOrderedSetValueForKey:@"pageObjects"];
	[pageObjects insertObjects:@[@1, @2, @3] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
	STAssertEquals([controller.pageObjects count], (NSUInteger)3, nil);
}

@end
