//
//  YXSection.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

@class YXAbstractCell;

@interface YXSection : NSObject <NSFastEnumeration>

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;

@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *headerView;

@property (nonatomic, readonly) YXAbstractCell *lastCell;
@property (nonatomic, readonly, getter=cellCount) NSInteger count;

+ (id)section;
+ (id)sectionWithHeader:(NSString *)header;
+ (id)sectionWithHeader:(NSString *)header footer:(NSString *)footer;

- (void)addCell:(YXAbstractCell *)cell;
- (void)removeCell:(YXAbstractCell *)cell;

- (YXAbstractCell *)cellAtIndex:(NSInteger)index;
- (NSInteger)indexOfCell:(YXAbstractCell *)cell;
- (void)removeAllCells;


@end
