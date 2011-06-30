//
//  YXSegmentedControlCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 6/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXSegmentedControlCell : YXAbstractCell

@property (nonatomic, copy) YXValueSenderBlock handler;
@property (nonatomic, copy) YXValueGetterBlock initialValueGetter;
@property (nonatomic, retain) NSArray *segmentedControlItems;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier segmentedControlItems:(NSArray *)items handler:(YXValueSenderBlock)handler initialValueGetter:(YXValueGetterBlock)initialValueGetter;

@end
