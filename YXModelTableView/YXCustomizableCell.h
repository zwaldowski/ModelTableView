//
//  YXCustomizableCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"

@class YXCustomizableCell;

typedef UITableViewCell *(^YXCustomizableBuildingBlock)(YXCustomizableCell *cell, UITableViewCell *reusable);

@interface YXCustomizableCell : YXAbstractCell <YXModelCellSupportsEditing>

@property (nonatomic, copy) YXSenderBlock selectionHandler;
@property (nonatomic, copy) YXCustomizableBuildingBlock buildingHandler;
@property (nonatomic) BOOL deselectsAutomatically;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier buildingHandler:(YXCustomizableBuildingBlock)buildingHandler selectionHandler:(YXSenderBlock)selectionHandler;

@end
