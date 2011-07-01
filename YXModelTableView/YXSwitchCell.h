//
//  YXSwitchCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXModelCell.h"

@interface YXSwitchCell : NSObject <YXModelCellWithEditing>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) YXValueGetterBlock initialValueGetter;
@property (nonatomic, copy) YXValueSenderBlock handler;
@property (nonatomic) BOOL togglesOnSelect;

+ (id)cellWithTitle:(NSString *)title initialValueGetter:(YXValueGetterBlock)initialValueGetter handler:(YXValueSenderBlock)handler;

@end
