//
//  GetCities.h
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-4.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCities : NSObject

@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) NSMutableArray *citiesArray;
@property (nonatomic,retain) NSString *citiyId;
@property (nonatomic,retain) NSDictionary *citiesDic;
@property (nonatomic,retain) NSMutableArray *regionsArray;
@property (nonatomic,retain) NSMutableDictionary *regionsAndCitiesDic;

-(void)getCities;
@end
