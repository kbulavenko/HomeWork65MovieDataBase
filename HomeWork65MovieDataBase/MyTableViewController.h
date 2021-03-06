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

@interface MyTableViewController : NSObject<NSTableViewDataSource>


@property   (strong) MyDB   *myDB;
@property   (strong) NSMutableArray<NSDictionary *>    *films;
@property  (strong)  NSMutableArray<NSDictionary *>    *genres;
@property  (strong) NSMutableArray<NSDictionary *>    *directors;



- (instancetype)initWithDB: (MyDB *) db1;


@end
