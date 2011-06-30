//
//  YXKVOValueCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 6/29/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXAbstractCell.h"

@interface YXKVCValueCell : YXAbstractCell <YXModelCellSupportsEditing>

@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *key;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title object:(id)object key:(NSString *)key;

@end
