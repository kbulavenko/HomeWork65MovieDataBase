//
//  ViewController.h
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyTableViewController.h"
//#import "MyTableViewController1.h"

#import "MyViewController.h"
//#import "MyViewController1.h"
#import "MyTestViewController.h"

#import "MyDB.h"

@interface ViewController : NSViewController

@property  MyTableViewController  *MTVC;
//@property  MyTableViewController1  *MTVC1;
@property  MyDB                     *db;

@property (strong, atomic) MyViewController       *MyVCFilms;
@property (strong, atomic) MyTestViewController       *MyVCGenres;
@property (strong, atomic) MyViewController       *MyVCDirectors;


@property (weak) IBOutlet NSTabView *tabView;


@end

