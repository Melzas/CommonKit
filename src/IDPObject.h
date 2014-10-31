//
//  IDPObject.h
//  IDPKit
//
//  Created by Anton Rayev on 5/23/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@protocol IDPObject <NSObject>

@optional

- (void)performSelector:(SEL)selector withObjects:(id<NSObject>)firstObject, ...
	NS_REQUIRES_NIL_TERMINATION;

@end
