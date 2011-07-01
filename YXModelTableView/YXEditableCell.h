//
//  YXEditableCell.h
//  YXModelTableViews
//
//  Created by Roman Busyghin on 7/23/10.
//  Copyright 2010 Яндекс. All rights reserved.
//

#import "YXModelCell.h"

@interface YXEditableCell : NSObject <YXModelCellWithEditing>

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) YXSenderBlock handler;

+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder value:(NSString *)value;
+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder handler:(YXSenderBlock)handler;
+ (id)cellWithTitle:(NSString *)title placeholder:(NSString *)placeholder value:(NSString *)value handler:(YXSenderBlock)handler;

@end
