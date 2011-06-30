//
//  YXEditableCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXEditableCell : YXAbstractCell <YXModelCellSupportsEditing>

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) YXSenderBlock handler;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder value:(NSString *)value;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder handler:(YXSenderBlock)handler;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier label:(NSString *)labelText placeholder:(NSString *)placeholder value:(NSString *)value handler:(YXSenderBlock)handler;

@end
