//
//  MyDB.h
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Movies.h"
#import "FMDB.h"


@interface MyDB : NSObject

@property   FMDatabase   *db;


- (instancetype)initWithPath: (NSString *)  p;
-(void)makeDBWithNum: (int) num;


-(NSMutableArray<NSDictionary *> *) getFilms;

-(NSMutableArray<NSDictionary *> *) getGenres;
-(NSMutableArray<NSDictionary *> *) getDirectors;

@end
