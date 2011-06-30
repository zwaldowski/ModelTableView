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

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title object:(id)object key:(NSString *)key {
	YXKVCCheckmarkCell * cell = [YXKVCCheckmarkCell new];
    
    cell.reuseIdentifier = reuseIdentifier;
	cell.title = title;
	cell.object = object;
	cell.key = key;
    cell.initialValueGetter = ^NSNumber *(YXCheckmarkCell *cell){
        return [object valueForKey:key];
    };
    cell.handler = ^(YXCheckmarkCell *cell, NSNumber *value){
        [object setValue:value forKey:key];
        YXSenderBlock block = [(YXKVCCheckmarkCell *)cell updateAction];
        if (block)
            block(cell);
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
