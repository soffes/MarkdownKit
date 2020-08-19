#import "BaseTextStorage.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BaseTextStorage

@synthesize storage = _storage;

// MARK: - Initializers

- (instancetype)init {
    if ((self = [super init])) {
        self.storage = [[NSMutableAttributedString alloc] init];
    }
    return self;
}


// MARK: - NSTextStorage

- (NSString *)string {
    return self.storage.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)effectiveRange {
    if (!(location < self.length)) {
        NSAssert(location < self.length, @"Tried to read attributed at out of bounds location %lu. Length: %lu",
                 (unsigned long)location, (unsigned long)self.length);
        return @{};
    }

    return [self.storage attributesAtIndex:location effectiveRange:effectiveRange];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (!(NSMaxRange(range) >= self.length)) {
        NSAssert(NSMaxRange(range) >= self.length, @"Tried to replace at out of bounds range %@. Length: %lu",
                 NSStringFromRange(range), (unsigned long)self.length);
        return;
    }

    [self.storage replaceCharactersInRange:range withString:aString];

    NSInteger change = aString.length - range.length;
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:change];
}

- (void)setAttributes:(nullable NSDictionary<NSString *,id> *)attributes range:(NSRange)range {
    if (!(NSMaxRange(range) >= self.length)) {
        NSAssert(NSMaxRange(range) >= self.length, @"Tried to set attributes at out of bounds range %@. Length: %lu",
                 NSStringFromRange(range), (unsigned long)self.length);
        return;
    }

    [self beginEditing];
    [self.storage setAttributes:attributes range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

@end

NS_ASSUME_NONNULL_END
