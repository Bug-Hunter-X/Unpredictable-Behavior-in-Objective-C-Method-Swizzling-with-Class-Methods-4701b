// Solution: Manage Swizzling Order and Use a Centralized Swizzling Manager

Instead of swizzling in each class's +load method, use a dedicated manager class to control the swizzling process and ensure a consistent order.

```objectivec
// SwizzlingManager.h
#import <Foundation/Foundation.h>

@interface SwizzlingManager : NSObject

+ (void)performSwizzling;

@end

// SwizzlingManager.m
#import "SwizzlingManager.h"
#import "ClassA.h"
#import "ClassB.h"

@implementation SwizzlingManager

+ (void)performSwizzling {
    // Swizzle Class A methods first
    Method originalMethodA = class_getClassMethod([ClassA class], @selector(originalMethod));
    Method swizzledMethodA = class_getClassMethod([ClassA class], @selector(swizzledMethod));
    method_exchangeImplementations(originalMethodA, swizzledMethodA);
    
    // Then swizzle Class B methods
    Method originalMethodB = class_getClassMethod([ClassB class], @selector(originalMethod));
    Method swizzledMethodB = class_getClassMethod([ClassB class], @selector(swizzledMethod));
    method_exchangeImplementations(originalMethodB, swizzledMethodB);
}
@end

// Class A and Class B remain largely the same, removing the +load method
```

This approach guarantees that the swizzling occurs in the intended sequence, preventing the overwrite issue and ensuring the correct functionality of both classes.