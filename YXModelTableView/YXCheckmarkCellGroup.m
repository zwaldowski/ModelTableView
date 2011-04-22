//
//  YXCheckmarkCellGroup.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXCheckmarkCellGroup.h"

@interface YXCheckmarkCellGroup ()
- (void)selectCell:(YXCheckmarkCell *)cell;
- (NSMutableArray *)mutableCells;
@end


@implementation YXCheckmarkCellGroup

+ (id)group {
    return [[[super alloc] init] autorelease];
}

+ (id)groupWithTarget:(id)target action:(SEL)action {
    return [[[super alloc] initWithTarget:target action:action] autorelease];
}

- (id)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super init])) {
        self.target = target;
        self.action = action;
    }
    return self;
}

#pragma mark -
#pragma mark Public interface

- (void)addCell:(YXCheckmarkCell *)cell setSelected:(BOOL)selected {
	NSAssert(cell != nil, @"");
	
	[[self mutableCells] addObject:cell];
	
	if (selected) {
		self.selectedCell = cell;
	}
	
	cell.target = self;
	cell.initialValueGetter = @selector(initialValueForCell:);
	cell.action = @selector(cell:changedValue:);
	cell.willChangeHandler = @selector(cell:willChangeValue:);
}

- (void)removeCell:(YXCheckmarkCell*)cell {
	NSAssert(cell != nil, @"");
	
	if (cell.target == self) {
		cell.target = nil;
	}
	
	[[self mutableCells] removeObject:cell];
	
	if (self.selectedCell == cell) { // cell can be already disposed here
		[self selectCell:nil];
	}
}

- (NSInteger)indexOfCell:(YXCheckmarkCell *)cell {
    return [[self mutableCells] indexOfObject:cell];
}


#pragma mark -
#pragma mark Checkmark cell callbacks


- (NSNumber *)initialValueForCell:(YXCheckmarkCell *)cell {
	BOOL boolValue = (cell == self.selectedCell);
	return [NSNumber numberWithBool:boolValue];
}

- (void)cell:(YXCheckmarkCell *)cell changedValue:(NSNumber *)selected {
	if ([selected boolValue] == YES) {
		[self selectCell:cell];
	}
}

- (BOOL)cell:(YXCheckmarkCell*)cell willChangeValue:(NSNumber*)selected {
	if (self.selectedCell == cell) {
		return NO;
	}
	return YES;
}


#pragma mark -
#pragma mark Private


- (void)selectCell:(YXCheckmarkCell *)cell {
	YXCheckmarkCell * previousCell = self.selectedCell;
	
	self.selectedCell = cell;
	
	if (previousCell != nil) {
		[previousCell update];
	}
	
	if ([self.target respondsToSelector:self.action]) {
		[self.target performSelector:self.action withObject:self withObject:cell];
	}
}

- (NSMutableArray *)mutableCells {
	if (_cells == nil) {
		_cells = [[NSMutableArray alloc] initWithCapacity:10];
	}
	return _cells;
}


#pragma mark -
#pragma mark Memory management


@synthesize target, action, selectedCell;


- (void)dealloc {
    [_cells release];
	selectedCell = nil;
	[super dealloc];
}


@end
