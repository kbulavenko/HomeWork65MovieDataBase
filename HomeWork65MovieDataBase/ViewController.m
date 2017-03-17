//
//  ViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize   MTVC, MyVCFilms, MyVCGenres, MyVCDirectors,tabView, db, filmsItem, genresItem, directorsItem;
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    //   Create   DB
    NSString   *dbPath  =  [NSString   stringWithFormat:@"%@/Documents/filmsNormKeyed.db", NSHomeDirectory()];
    NSLog(@"%@", dbPath);
    
    self.db  = [[MyDB alloc] initWithPath: dbPath];
   // [self->db makeDBWithNum: 300000];
    

    
    
    //     Create TableDataSource
    
    self.MTVC      = [[MyTableViewController  alloc] initWithDB: self.db];
    if(self.MTVC == nil)
    {
        NSLog(@"Data Source Nil");
        exit(1);
    }
    
    
    
    //  Begin
    
    srand((unsigned int) time(NULL));
    
    
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
    
    
    //  ***********************   Films  *********************
    
    //     Create tab  Films
    
    self.MyVCFilms      = [[MyViewController   alloc] initWithNibName: nil bundle: nil ];
    self.filmsItem          = [NSTabViewItem tabViewItemWithViewController: self.MyVCFilms];
    self.filmsItem.identifier        =  @"films";
    self.filmsItem.label             =  @"Таблица Фильмов";
     [self.tabView    addTabViewItem: self.filmsItem];
    
    //     Select Tab Films
           // First Item selcted by default
    //     Create and add table  columns for table films
    [self.MyVCFilms createTableColumnsWithDictionary: filmsDict];
    
    
    //  ***********************   Genres  *********************
    
    //     Create tab  Genres
    self.MyVCGenres     = [[MyViewController   alloc] initWithNibName: nil bundle: nil];
    self.genresItem         = [NSTabViewItem tabViewItemWithViewController: self.MyVCGenres];
    self.genresItem.identifier       =  @"genres";
    self.genresItem.label            =  @" Таблица Жанров";
    [self.tabView    addTabViewItem: self.genresItem];

    
    
    //     Select Tab Genres
    [self.tabView selectTabViewItem: genresItem];
    //     Create and add table  columns for table Genres
    [self.MyVCGenres createTableColumnsWithDictionary: genresDict];
    
   
    
    //  ***********************   Directors  *********************
    
    //     Create tab  Directors
     self.MyVCDirectors  = [[MyViewController   alloc] initWithNibName: nil bundle: nil ];
    self.directorsItem      = [NSTabViewItem tabViewItemWithViewController: self.MyVCDirectors];
    self.directorsItem.identifier    =  @"directors";
    self.directorsItem.label         =  @"Таблица Режиссеров";
    [self.tabView    addTabViewItem: self.directorsItem];
    
    //     Select Tab Directors  (иначе не работает )
    [self.tabView selectTabViewItem: filmsItem];   // Выделяем первый итем
    [self.tabView selectTabViewItem: directorsItem];  // И только теперь можем выделить другой
    
    //     Create and add table  columns for table Directors
    [self.MyVCDirectors createTableColumnsWithDictionary: directorsDict];
    
    
    //  Set Identifier and Table Data Source
    self.MyVCFilms.tableView.identifier       = @"TableViewIdFilms";
    self.MyVCGenres.tableView.identifier      = @"TableViewIdGenres";
    self.MyVCDirectors.tableView.identifier   = @"TableViewIdDirectors";

    
    //   Задаем Источники данных TableView
    
    self.MyVCFilms.tableView.dataSource     = self.MTVC;
    self.MyVCDirectors.tableView.dataSource = self.MTVC;
    self.MyVCGenres.tableView.dataSource    = self.MTVC;
    
  //////////    END   ---------------------------------   **********************
  
   
    //  NSLog(@"%@ %@ %@ %@ %@ %@ ", filmsItem, genresItem, directorsItem, MyVCFilms, MyVCGenres, MyVCDirectors);
    //
    
    

    
    
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
