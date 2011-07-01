//
//  YXKVOSwitchCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXKVCSwitchCell.h"

@implementation YXKVCSwitchCell

@synthesize object, key;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithTitle:(NSString *)title object:(id)object key:(NSString *)key {
	YXKVCSwitchCell *cell = [YXKVCSwitchCell new];
    
    cell.title = title;
	cell.object = object;
	cell.key = key;
    cell.initialValueGetter = ^NSNumber *(YXKVCSwitchCell *cell) {
        return [object valueForKey:key];
    };
    cell.handler = ^(YXKVCSwitchCell *cell, NSNumber *value){
        [object setValue:value forKey:key];
    };

	return [cell autorelease];
}

- (void)dealloc {
    self.object = nil;
    self.key = nil;
    
	[super dealloc];
}

@end
