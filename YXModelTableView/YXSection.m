//
//  YXSection.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXSection.h"


@implementation YXSection


#pragma mark -
#pragma mark Objec lifecycle

- (id)init {
	return [self initWithHeader:nil footer:nil];
}

- (id)initWithHeader:(NSString *)header footer:(NSString *)footer {
	self = [super init];
	if (self) {
		cells_ = [[NSMutableArray alloc] init];
		header_ = [header copy];
		footer_ = [footer copy];
	}
	return self;
}

+ (id)section {
	return [[self class] sectionWithHeader:nil footer:nil];
}

+ (id)sectionWithHeader:(NSString *)header footer:(NSString *)footer {
	return [[[[self class] alloc] initWithHeader:header footer:footer] autorelease];
}


#pragma mark -
#pragma mark Public interface

- (void)addCell:(YXAbstractCell *)cell {
	[cells_ addObject:cell];
}

- (void)removeCell:(YXAbstractCell *)cell {
	[cells_ removeObject:cell];
}

- (YXAbstractCell *)cellAtIndex:(NSInteger)index {
    //if (index > [cells_ count]) return nil;
    return [cells_ objectAtIndex:index];
}

- (NSInteger)indexOfCell:(YXAbstractCell *)cell {
    return [cells_ indexOfObject:cell];
}

- (NSInteger)cellCount {
    return [cells_ count];
}

- (void)removeAllCells {
    [cells_ removeAllObjects];
}

#pragma mark -
#pragma mark Memory management


@synthesize header = header_;
@synthesize footer = footer_;
@synthesize headerView = headerView_;
@synthesize footerView = footerView_;


- (void)dealloc {
	[header_ release];
	[footer_ release];

	[headerView_ release];
	[footerView_ release];

	[cells_ release];

	[super dealloc];
}


@end
