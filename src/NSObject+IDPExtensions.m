//
//  NSObject+IDPExtensions.m
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPExtensions.h"

static const NSUInteger	kIDPFirstArgumentIndex = 2;

@implementation NSObject (IDPExtensions)

+ (id)object {
    return [[self new] autorelease];
}

- (void)baseInit {
    
}

+ (NSString *)stringOfClass {
    return NSStringFromClass(self);
}

- (void)performSelector:(SEL)selector withObjects:(id<NSObject>)firstObject, ...
	NS_REQUIRES_NIL_TERMINATION
{
	if ([self respondsToSelector:selector]) {
		NSMethodSignature *methodSignature = [[self class]
											  instanceMethodSignatureForSelector:selector];
		
		NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
		[invocation setTarget:self];
		[invocation setSelector:selector];
		
		NSUInteger argumentIndex = kIDPFirstArgumentIndex;
		
		va_list arguments;
		
		va_start(arguments, firstObject);
		for (id argument = firstObject; argument != nil; argument = va_arg(arguments, id)) {
			[invocation setArgument:&argument atIndex:argumentIndex++];
		}
		va_end(arguments);
		
		[invocation invoke];
	}
}

@end
