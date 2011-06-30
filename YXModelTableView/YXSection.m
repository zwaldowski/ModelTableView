//
//  YXSection.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXSection.h"

@interface YXSection()
@property (nonatomic, retain) NSMutableArray *cells;
@end

@implementation YXSection

@synthesize header, footer, headerView, footerView, cells;

#pragma mark -
#pragma mark Object lifecycle

+ (id)section {
	return [self sectionWithHeader:nil footer:nil];
}

+ (id)sectionWithHeader:(NSString *)header {
	return [self sectionWithHeader:header footer:nil];
}

+ (id)sectionWithHeader:(NSString *)header footer:(NSString *)footer {
    YXSection *instance = [self new];
    
    instance.header = header;
    instance.footer = footer;
    
    return [instance autorelease];
}

- (id)init {
    if ((self = [super init])) {
        self.cells = [NSMutableArray array];
    }
	return self;
}

- (void)dealloc {
    self.header = nil;
    self.footer = nil;
    self.headerView = nil;
    self.footerView = nil;
    self.cells = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark Public interface

- (void)addCell:(YXAbstractCell *)cell {
	[self.cells addObject:cell];
}

- (void)removeCell:(YXAbstractCell *)cell {
	[self.cells removeObject:cell];
}

- (YXAbstractCell *)cellAtIndex:(NSInteger)index {
    return [self.cells objectAtIndex:index];
}

- (NSInteger)indexOfCell:(YXAbstractCell *)cell {
    return [self.cells indexOfObject:cell];
}

- (NSInteger)cellCount {
    return self.cells.count;
}

- (void)removeAllCells {
    [self.cells removeAllObjects];
}

- (YXAbstractCell *)lastCell {
    return [self.cells lastObject];
}

#pragma mark -
#pragma NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id [])buffer count:(NSUInteger)len {
    return [self.cells countByEnumeratingWithState:state objects:buffer count:len];
}

@end
