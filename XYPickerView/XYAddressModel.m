//
//  XYAddressModel.m
//  XYPIckerView
//
//  Created by xiyedev on 2017/9/14.
//  Copyright © 2017年 YeJiong. All rights reserved.
//

#import "XYAddressModel.h"

@implementation XYProvinceModel


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {
        
        _code = dictionary[@"k"];
        _name = dictionary[@"v"];
        NSArray *cityArr = dictionary[@"n"];
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSDictionary *dict in cityArr) {
            XYCityModel *cityModel = [[XYCityModel alloc] initWithDictionary:dict];
            
            [tempArr addObject:cityModel];
        }
        self.city = tempArr;
    }
    return self;
}


@end


@implementation XYCityModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        
        _name = dict[@"v"];
        _code = dict[@"k"];
        NSArray *townArr = dict[@"n"];
        NSMutableArray *tempArr = [NSMutableArray new];
        
        for (NSDictionary *dictionary in townArr) {
            XYTownModel *model = [[XYTownModel alloc] initWithDictionary:dictionary];
            [tempArr addObject:model];
        }
        self.town = tempArr;
    }
    return self;
}

@end


@implementation XYTownModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        _code = dictionary[@"k"];
        _name = dictionary[@"v"];
    }
    return self;
}

@end
