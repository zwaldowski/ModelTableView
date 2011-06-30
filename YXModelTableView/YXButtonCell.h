//
//  YXButtonCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXButtonCell : YXAbstractCell <YXModelCellSupportsEditing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) YXSenderBlock handler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title handler:(YXSenderBlock)handler;

@end
