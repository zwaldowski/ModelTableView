//
//  YXSegmentedControlCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 6/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXModelCell.h"

@interface YXSegmentedControlCell : NSObject <YXModelCell>

@property (nonatomic, copy) YXValueSenderBlock handler;
@property (nonatomic, copy) YXValueGetterBlock initialValueGetter;
@property (nonatomic, copy) NSArray *segmentedControlItems;

+ (id)cellWithSegmentedControlItems:(NSArray *)items handler:(YXValueSenderBlock)handler initialValueGetter:(YXValueGetterBlock)initialValueGetter;

@end
