//
//  YXStaticLabelCell.h
//  YXModelTableViews
//
//  Created by Zachary Waldowski on 4/22/11.
//  Copyright 2011 Dizzy Technology. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXStaticLabelCell : YXAbstractCell <YXModelCellSupportsEditing>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic) UITextAlignment alignment;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text;
+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier text:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(UITextAlignment)align;

@end
