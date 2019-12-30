

#import "BDModel.h"
#import "BDExtend.h"

@implementation BDModel

+ (id)safeWithDic:(NSDictionary *)dic
{
    return dic;
}

@end

@implementation DoorRecordModel

+ (id)safeWithDic:(NSDictionary *)dic
{
    DoorRecordModel *model = [[DoorRecordModel alloc] initWithDic:dic];
    return model;
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self && [dic bd_isValue])
    {
        self.doorId = [dic bd_safeIntForKey:@"doorId"];
        self.type = [dic bd_safeIntForKey:@"type"];
        self.name = [dic bd_safeStringForKey:@"name"];
        self.remote = [dic bd_safeIntForKey:@"remote"];
        self.bluetooth = [dic bd_safeIntForKey:@"bluetooth"];
        self.qrCode = [dic bd_safeIntForKey:@"qrCode"];
        self.openType = [dic bd_safeIntForKey:@"openType"];
        self.nickname = [dic bd_safeStringForKey:@"nickname"];
        self.time = [dic bd_safeLongLongForKey:@"time"];
        self.deviceType = [dic bd_safeIntForKey:@"deviceType"];
        self.passWord = [dic bd_safeIntForKey:@"passWord"];
    }
    return self;
}

@end

@implementation DoorTypeModel

+ (id)safeWithDic:(NSDictionary *)dic
{
    DoorTypeModel *model = [[DoorTypeModel alloc] initWithDic:dic];
    return model;
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self && [dic bd_isValue])
    {
        self.name = [dic bd_safeStringForKey:@"name"];
        
        NSArray *array = [dic objectForKey:@"doorInfo"];
        self.doorArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array)
        {
            DoorRecordModel *obj = [DoorRecordModel safeWithDic:dic];
            [self.doorArray addObject:obj];
        }
    }
    return self;
}

@end
