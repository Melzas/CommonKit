//
//  NSObject+IDPExtensions.h
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IDPExtensions)

+ (id)object;
+ (NSString *)stringOfClass;

- (void)baseInit;

- (void)performSelector:(SEL)selector withObjects:(id<NSObject>)firstObject, ...
	NS_REQUIRES_NIL_TERMINATION;

@end
