//
//  YXKVOCheckmarkCell.m
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXKVCCheckmarkCell.h"

@implementation YXKVCCheckmarkCell

@synthesize key, object, updateAction;

#pragma mark -
#pragma mark Object lifecycle

+ (id)cellWithTitle:(NSString *)title object:(id)object key:(NSString *)key {
	YXKVCCheckmarkCell * cell = [YXKVCCheckmarkCell new];
    
	cell.title = title;
	cell.object = object;
	cell.key = key;
    cell.initialValueGetter = ^NSNumber *(YXKVCCheckmarkCell *cell){
        return [object valueForKey:key];
    };
    cell.handler = ^(YXKVCCheckmarkCell *cell, NSNumber *value){
        [object setValue:value forKey:key];
        
        YXBlock block = cell.updateAction;
        if (block) block();
    };

	return [cell autorelease];
}

- (void)dealloc {
	self.key = nil;
	self.object = nil;
    self.updateAction = NULL;
	
	[super dealloc];
}

@end
