//
//  YXCheckmarkCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 5/17/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXAbstractCell.h"

@class YXCheckmarkCellGroup;

@interface YXCheckmarkCell : YXAbstractCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) YXValueGetterBlock initialValueGetter;
@property (nonatomic, copy) YXValueSenderBlock handler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title group:(YXCheckmarkCellGroup *)group;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title group:(YXCheckmarkCellGroup *)group selected:(BOOL)selected;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title initialValueGetter:(YXValueGetterBlock)initialValueGetter handler:(YXValueSenderBlock)handler;

- (void)update;

@end
