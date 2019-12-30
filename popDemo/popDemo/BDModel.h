

#import <Foundation/Foundation.h>

@interface BDModel : NSObject

+ (id)safeWithDic:(NSDictionary *)dic;

@end

#pragma mark ---------------------------------------- DoorRecordModel (开门记录管理)----------

@interface DoorRecordModel : BDModel

//开门id
@property (nonatomic, assign) int doorId;
//1 小区/园区 2、小区（单元） 3、园区最后一层（室）
@property (nonatomic, assign) int type;
//名字
@property (nonatomic, strong) NSString *name;
//远程
@property (nonatomic, assign) int remote;
//蓝牙
@property (nonatomic, assign) int bluetooth;
//二维码
@property (nonatomic, assign) int qrCode;

@property (nonatomic, assign) int openType;
//开门人
@property (nonatomic, strong) NSString *nickname;
//时间
@property (nonatomic, assign) long long time;
//判断设备
@property (nonatomic, assign) int deviceType;
//开门密码
@property (nonatomic, assign) int passWord;

@end

#pragma mark ---------------------------------------- DoorTypeModel (开门分类管理)----------

@interface DoorTypeModel : BDModel

//分类名
@property (nonatomic, strong) NSString *name;
//组
@property (nonatomic, strong) NSMutableArray *doorArray;

@end
