@import Darwin.TargetConditionals;

#if TARGET_OS_IPHONE
@import UIKit;
#else
@import AppKit;
#endif

NS_ASSUME_NONNULL_BEGIN

/// Concrete text storage intended to be subclassed.
@interface BaseTextStorage : NSTextStorage
@end

@interface BaseTextStorage ()
@property (nonatomic) NSMutableAttributedString *storage;
@end

NS_ASSUME_NONNULL_END
