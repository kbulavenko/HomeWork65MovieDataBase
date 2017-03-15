//
//  ViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize   MTVC, MyVCFilms, MyVCGenres, MyVCDirectors,tabView, db;
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    srand((unsigned int) time(NULL));
    NSString   *dbPath  =  [NSString   stringWithFormat:@"%@/Documents/filmsNormKeyed.db", NSHomeDirectory()];
    NSLog(@"%@", dbPath);
    
    self.db  = [[MyDB alloc] initWithPath: dbPath];
    
    self.MTVC = [[MyTableViewController  alloc] initWithDB: self.db];
    self.MTVC1 = [[MyTableViewController1  alloc] initWithDB: self.db];
    
    
    
    self.MyVCFilms = [[MyViewController   alloc] initWithNibName: @"MyViewController1" bundle: nil];
    self.MyVCGenres = [[MyViewController1   alloc] initWithNibName: @"MyViewController2" bundle: nil];
    self.MyVCDirectors = [[MyViewController   alloc] initWithNibName: @"MyViewController3" bundle: nil];
    
    
    NSDictionary    *genresDict1  = @{
                                     @"0id" : @"ganresName",
                                     @"0title" : @"Жанр",
                                     };
    
   // [self.MyVCGenres  clearTableView];
    [self.MyVCGenres  createTableColumnsWithDictionary: genresDict1];
    self.MyVCGenres.tableView.dataSource = self.MTVC;
    

    
    
    
    
    
    
  //  NSArray   *tabs  = self.tabView.tabViewItems;
    
    NSTabViewItem   *filmsItem          =   [NSTabViewItem tabViewItemWithViewController: self.MyVCFilms];
    NSTabViewItem   *genresItem         = [NSTabViewItem tabViewItemWithViewController: self.MyVCGenres];
    NSTabViewItem   *directorsItem      = [NSTabViewItem tabViewItemWithViewController: self.MyVCDirectors];
    NSLog(@"%@ %@ %@ %@ %@ %@ ", filmsItem, genresItem, directorsItem, MyVCFilms, MyVCGenres, MyVCDirectors);
//
    
    filmsItem.identifier    =  @"films";
    genresItem.identifier    =  @"genres";
    directorsItem.identifier    =  @"directors";
    
    filmsItem.label    =  @"Таблица Фильмов";
    genresItem.label    =  @" Таблица Жанров";
    directorsItem.label    =  @"Таблица Режиссеров";
    
    [self.tabView    addTabViewItem: filmsItem];
    [self.tabView    addTabViewItem: genresItem];
    [self.tabView    addTabViewItem: directorsItem];
    
    
    
//    
//    NSString  *identifierTC = @"11111";
//    NSString  *titleTC = @"111111111";
//    NSLog(@"identifier = %@ title = %@", identifierTC, titleTC);
//    
//    NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: identifierTC];
//    TC.title    = titleTC;
//    TC.headerCell.stringValue   = titleTC;
//    TC.resizingMask  = NSTableColumnAutoresizingMask;
//    TC.width  = 50;
//    [self.MyVCFilms.tableView  addTableColumn: TC];

    [NSThread  sleepForTimeInterval: 0.5];
    
    NSDictionary    *genresDict  = @{
                                     @"0id" : @"ganresName",
                                     @"0title" : @"Жанр",
                                     };
    
   // [self.MyVCGenres  clearTableView];
    [self.MyVCGenres  createTableColumnsWithDictionary: genresDict];
    self.MyVCGenres.tableView.dataSource = self.MTVC;

    
    
    NSDictionary    *filmsDict  = @{
                                    @"0id" : @"filmsName",
                                    @"1id" : @"filmsGenre",
                                    @"2id" : @"filmsDirector",
                                    @"0title" : @"Название",
                                    @"1title" : @"Жанр",
                                    @"2title" : @"Режиссер",
                                    };

    [self.MyVCFilms  clearTableView];
    [self.MyVCFilms  createTableColumnsWithDictionary: filmsDict];
    self.MyVCFilms.tableView.dataSource = self.MTVC;
    
   
    NSDictionary    *directorsDict  = @{
                                     @"0id" : @"directorsName",
                                     @"0title" : @"Режиссер",
                                     };
    
    [self.MyVCDirectors  clearTableView];
    [self.MyVCDirectors  createTableColumnsWithDictionary: directorsDict];
    self.MyVCDirectors.tableView.dataSource = self.MTVC;

    
    
    NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: @"ganresName"];
    TC.title    = @"Title Жанр";
    TC.headerCell.stringValue   = @"headerCell Жанр";
    TC.resizingMask  = NSTableColumnAutoresizingMask;
    TC.width  = 300;
    [self.MyVCGenres.tableView  addTableColumn: TC];

    
    self.MyVCGenres.tableView.dataSource = self.MTVC;
    self.MyVCDirectors.tableView.dataSource = self.MTVC;

    
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
