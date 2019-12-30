

#import "BDExtend.h"

@implementation NSObject(BDExtend)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSString(BDExtend)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]] && ([self length] > 0))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

@implementation NSData(BDExtend)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSNumber(NJBD_IsValue)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSArray(BDExtend)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]] && ([self count] > 0))
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSMutableArray (BDExtend)

@end

@implementation NSDictionary(BDExtend)

- (BOOL)bd_isValue
{
    if (self != nil && ![self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}

- (int)bd_safeIntForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [value intValue];
        }
    }
    return 0;
}

- (BOOL)bd_safeBoolForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [value boolValue];
        }
    }
    return NO;
}

- (float)bd_safeFloatForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [value floatValue];
        }
    }
    return 0.0f;
}

- (double)bd_safeDoubleForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [value doubleValue];
        }
    }
    return 0.0f;
}

- (long long)bd_safeLongLongForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [value longLongValue];
        }
    }
    return 0.0l;
}

- (NSString *)bd_safeStringForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return [NSString stringWithFormat:@"%@",value];
        }
    }
    return @"";
}

- (NSDictionary *)bd_safeDictionaryForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return value;
        }
    }
    return nil;
}

- (NSArray *)bd_safeArrayForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return value;
        }
    }
    return nil;
}

- (id)bd_safeObjectForKey:(NSString *)key
{
    if ([self bd_isValue] && [key bd_isValue])
    {
        id value = [self objectForKey:key];
        if ([value bd_isValue])
        {
            return value;
        }
    }
    return nil;
}

@end

@implementation NSMutableDictionary(BDExtend)

- (void)bd_setObject:(id)object Key:(NSString *)key
{
    if ([self bd_isValue] && [object bd_isValue] && [key bd_isValue])
    {
        [self setObject:object forKey:key];
    }
}

@end
