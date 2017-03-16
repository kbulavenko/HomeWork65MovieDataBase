//
//  ViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize   MTVCfilms, MTVCgenres, MTVCdirectors, MyVCFilms, MyVCGenres, MyVCDirectors,tabView, db, filmsItem, genresItem, directorsItem;
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    srand((unsigned int) time(NULL));
    NSString   *dbPath  =  [NSString   stringWithFormat:@"%@/Documents/filmsNormKeyed.db", NSHomeDirectory()];
    NSLog(@"%@", dbPath);
    
    self.db  = [[MyDB alloc] initWithPath: dbPath];
    [self->db makeDBWithNum: 100];
    
    
    NSDictionary    *filmsDict  = @{
                                    @"0id" : @"filmsName",
                                    @"1id" : @"filmsGenre",
                                    @"2id" : @"filmsDirector",
                                    @"0title" : @"Название             ",
                                    @"1title" : @"Жанр",
                                    @"2title" : @"Режиссер"
                                    };
    

    NSDictionary    *directorsDict  = @{
                                        @"0id" : @"directorsName",
                                        @"0title" : @"Режиссер          "
                                        };

    
    NSDictionary    *genresDict  = @{
                                     @"0id" : @"genresName",
                                     @"0title" : @"Жанр       "
                                     };

    
    
    
    self.MTVCfilms      = [[MyTableViewController  alloc] initWithDB: self.db];
    self.MTVCgenres     = [[MyTableViewController  alloc] initWithDB: self.db];
    self.MTVCdirectors  = [[MyTableViewController  alloc] initWithDB: self.db];
    
    
    
    
    self.MyVCFilms      = [[MyTestViewController   alloc] initWithNibName: nil bundle: nil andDictionary: filmsDict];
    self.MyVCGenres     = [[MyTestViewController   alloc] initWithNibName: nil bundle: nil andDictionary: genresDict];
    self.MyVCDirectors  = [[MyTestViewController   alloc] initWithNibName: nil bundle: nil andDictionary: directorsDict];
    
    self.MyVCFilms.tableView.identifier       = @"TableViewIdFilms";
    self.MyVCGenres.tableView.identifier      = @"TableViewIdGenres";
    self.MyVCDirectors.tableView.identifier   = @"TableViewIdDirectors";
    
    self.filmsItem          =   [NSTabViewItem tabViewItemWithViewController: self.MyVCFilms];
    self.genresItem         = [NSTabViewItem tabViewItemWithViewController: self.MyVCGenres];
    self.directorsItem      = [NSTabViewItem tabViewItemWithViewController: self.MyVCDirectors];
    NSLog(@"%@ %@ %@ %@ %@ %@ ", filmsItem, genresItem, directorsItem, MyVCFilms, MyVCGenres, MyVCDirectors);
//
    
    self.filmsItem.identifier    =  @"films";
    self.genresItem.identifier    =  @"genres";
    self.directorsItem.identifier    =  @"directors";
    
    self.filmsItem.label    =  @"Таблица Фильмов";
    self.genresItem.label    =  @" Таблица Жанров";
    self.directorsItem.label    =  @"Таблица Режиссеров";
    
   // self.filmsItem.
    
    
    [self.tabView    addTabViewItem: self.filmsItem];
    [self.tabView    addTabViewItem: self.genresItem];
    [self.tabView    addTabViewItem: self.directorsItem];

   
     [NSThread  sleepForTimeInterval: 0.5];
// 
//       [self.MyVCFilms  clearTableView];
//    [self.MyVCFilms  createTableColumnsWithDictionary: filmsDict];
//    
   
    
   // [self.MyVCDirectors  clearTableView];
  //  [self.MyVCDirectors  createTableColumnsWithDictionary: directorsDict];
   
    
//    NSDictionary    *genresDict  = @{
//                                     @"0id" : @"ganresName",
//                                     @"0title" : @"Жанр1111"
//                                     };
    
//    [self.MyVCGenres  clearTableView];
//    [self.MyVCGenres  createTableColumnsWithDictionary: genresDict];
    

//    
//        NSLayoutConstraint    *LCtopTtopV   = [NSLayoutConstraint  constraintWithItem: self.MyVCFilms.tableView
//                                                                            attribute: NSLayoutAttributeTop
//                                                                            relatedBy: NSLayoutRelationEqual
//                                                                               toItem: self.filmsItem.view
//                                                                            attribute: NSLayoutAttributeTop
//                                                                           multiplier: 1
//                                                                             constant: 5];
//    
//        [self.filmsItem.view addConstraint: LCtopTtopV];
//    
    //
    //    NSLayoutConstraint    *LCleftTleftV   = [NSLayoutConstraint  constraintWithItem: self.tableView
    //                                                                        attribute: NSLayoutAttributeLeft
    //                                                                        relatedBy: NSLayoutRelationEqual
    //                                                                           toItem: self.view
    //                                                                        attribute: NSLayoutAttributeLeft
    //                                                                       multiplier: 1
    //                                                                         constant: 5];
    //
    //    [self.view addConstraint: LCleftTleftV];
    //
    //    NSLayoutConstraint    *LCrightTrightV   = [NSLayoutConstraint  constraintWithItem: self.view
    //                                                                          attribute: NSLayoutAttributeRight
    //                                                                          relatedBy: NSLayoutRelationEqual
    //                                                                             toItem: self.tableView
    //                                                                          attribute: NSLayoutAttributeRight
    //                                                                         multiplier: 1
    //                                                                           constant: -5];
    //    
    //    [self.view addConstraint: LCrightTrightV];
    

    
    
    
    
    self.MyVCFilms.tableView.dataSource = self.MTVCfilms;
    self.MyVCDirectors.tableView.dataSource = self.MTVCdirectors;
    self.MyVCGenres.tableView.dataSource = self.MTVCgenres;

    
    
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
