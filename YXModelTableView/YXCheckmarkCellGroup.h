//
//  YXCheckmarkCellGroup.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/30/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCheckmarkCell.h"

@interface YXCheckmarkCellGroup : NSObject {
@private
	NSMutableArray *_cells;
}

+ (id)group;
+ (id)groupWithTarget:(id)target action:(SEL)action;
- (id)initWithTarget:(id)target action:(SEL)action;

@property (nonatomic, assign) YXCheckmarkCell *selectedCell;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action; // checkmarkCellGroup:group selectedCell:cell

- (void)addCell:(YXCheckmarkCell *)cell setSelected:(BOOL)selected;
- (void)removeCell:(YXCheckmarkCell *)cell;

- (NSInteger)indexOfCell:(YXCheckmarkCell *)cell;

@end
