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
{
    NSDictionary  *MyDBAddRowDictionary;
    NSDictionary  *MyDBSetRowDictionary;
    
}


@property   FMDatabase   *db;


- (instancetype)initWithPath: (NSString *)  p;
-(void)makeDBWithNum: (NSInteger) num;


-(NSMutableArray<NSDictionary *> *) getFilms;

-(NSMutableArray<NSDictionary *> *) getGenres;
-(NSMutableArray<NSDictionary *> *) getDirectors;
-(NSMutableArray<NSDictionary *> *) getFilmsFromStart: (NSInteger) startRow numRow: (NSInteger) numRow;
-(NSInteger)getFilmsCount;
-(void)dbReopen;
-(void)removeRow: (NSDictionary *) dict tableName: (NSString *) tn;
-(void)addRow: (NSDictionary *) dict tableName: (NSString *) tn;
-(void)setRow: (NSDictionary *) dict tableName: (NSString *) tn;
-(void)sqliteForeignKeyOn;

@end
