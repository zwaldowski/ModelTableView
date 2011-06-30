//
//  YXKVOSwitchCell.h
//  YXModelTableViews
//
//  Created by Mikhail Kalugin on 5/11/10.
//  Copyright 2010 Yandex. All rights reserved.
//

#import "YXSwitchCell.h"

@interface YXKVCSwitchCell : YXSwitchCell

@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSString *key;

+ (id)cellWithReuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title object:(id)object key:(NSString *)key;

@end
