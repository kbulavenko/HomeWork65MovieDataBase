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
#import "MyOneRowView.h"

#import "MyViewController.h"
//#import "MyViewController1.h"
//#import "MyTestViewController.h"
//#import "MyTestViewController.h"

#import "MyDB.h"

@interface ViewController : NSViewController

//@property  MyTableViewController  *MTVCfilms;
//@property  MyTableViewController  *MTVCgenres;
//@property  MyTableViewController  *MTVCdirectors;
@property  MyTableViewController  *MTVC;

//@property  MyTableViewController1  *MTVC1;
@property  MyDB                     *db;

@property (strong ) MyViewController       *MyVCFilms;
@property (strong) MyViewController       *MyVCGenres;
@property (strong) MyViewController       *MyVCDirectors;

@property (strong) NSTabViewItem   *filmsItem;
@property (strong) NSTabViewItem   *genresItem;
@property (strong) NSTabViewItem   *directorsItem;



@property (weak) IBOutlet NSTabView *tabView;


@end

