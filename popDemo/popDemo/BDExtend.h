

#import <Foundation/Foundation.h>

@interface NSObject(BDExtend)

/**
 验证NSString是否有值
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

@end

@interface NSString(BDExtend)

/**
 验证NSString是否有值
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

@end

@interface NSData(BDExtend)

/**
 验证NSData是否有值
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

@end

@interface NSNumber(BDExtend)

/**
 验证字典是否为空
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

@end

@interface NSArray(BDExtend)

/**
 验证NSArray是否有值
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

@end

@interface NSMutableArray(BDExtend)

@end

@interface NSDictionary(BDExtend)

/**
 验证字典是否为空
 
 @return （YES：有值 NO：空）
 */
- (BOOL)bd_isValue;

/**
 保存为int类型数据
 
 @param key 键
 @return 值
 */
- (int)bd_safeIntForKey:(NSString *)key;

/**
 保存为BOOL类型数据
 
 @param key 键
 @return 值
 */
- (BOOL)bd_safeBoolForKey:(NSString *)key;

/**
 保存为float类型数据
 
 @param key 键
 @return 值
 */
- (float)bd_safeFloatForKey:(NSString *)key;

/**
 保存为double类型数据
 
 @param key 键
 @return 值
 */
- (double)bd_safeDoubleForKey:(NSString *)key;

/**
 保存为long long类型数据
 
 @param key 键
 @return 值
 */
- (long long)bd_safeLongLongForKey:(NSString *)key;

/**
 保存为NSString类型数据
 
 @param key 键
 @return 值
 */
- (NSString *)bd_safeStringForKey:(NSString *)key;

/**
 保存为NSDictionary类型数据
 
 @param key 键
 @return 值
 */
- (NSDictionary *)bd_safeDictionaryForKey:(NSString *)key;

/**
 保存为NSArray类型数据
 
 @param key 键
 @return 值
 */
- (NSArray *)bd_safeArrayForKey:(NSString *)key;

/**
 保存为id类型数据
 
 @param key 键
 @return 值
 */
- (NSObject *)bd_safeObjectForKey:(NSString *)key;

@end

@interface NSMutableDictionary(BDExtend)

/**
 根据key设置Object对象
 
 @param object Object对象
 @param key key值
 */
- (void)bd_setObject:(id)object Key:(NSString *)key;

@end

