//
//  UIImageToDataTransformer.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-24.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "UIImageToDataTransformer.h"

@implementation UIImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
    //正反方向的转换都支持
	return YES;
}

+ (Class)transformedValueClass {
    //输出是NSData格式
	return [NSData class];
}

- (id)transformedValue:(id)value {
    //属性->持久层数据库
    //从UIImage格式转换成NSData格式
	return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    //持久层数据库->属性
    //从NSData格式转换成UIImage格式
	return [[UIImage alloc] initWithData:value];
}


@end
