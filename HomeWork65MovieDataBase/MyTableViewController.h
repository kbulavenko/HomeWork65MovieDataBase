//
//  MyTableViewController.h
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "MyDB.h"




// Switch YES NO to select partially buffered (YES) or full buffered mode DB reading
#define BUFFEREDTV  YES




@interface MyTableViewController : NSObject<NSTableViewDataSource>
{
    NSInteger                          startRow;      // Начальный номер строки в базе
    NSInteger                          countRows;     // Количество строк в буфере
    NSMutableArray<NSDictionary *>      *filmsBuffer;   // Буфер
}

@property   (strong) MyDB   *myDB;
@property   (strong) NSMutableArray<NSDictionary *>    *films;
@property   (strong)  NSMutableArray<NSDictionary *>   *genres;
@property   (strong) NSMutableArray<NSDictionary *>    *directors;



- (instancetype)initWithDB: (MyDB *) db1;

-(void) deleteRow: (NSInteger) index;
-(void) addRow : (NSDictionary *) dict;
-(void) editRow: (NSDictionary *) dict;


@end
