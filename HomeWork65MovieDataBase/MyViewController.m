//
//  MyViewController.m
//  HomeWork65MovieDataBase
//
//  Created by Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize tableView, btnAdd, btnDel, btnEdt;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
   
    NSLog(@"MyViewController viewDidLoad");
    [self.tableView sizeToFit];
}

- (void)dealloc
{
    self->MTVC = nil;
}

-(void)setMTVC : (MyTableViewController *) m   //  Установить указатель, иначе
{
    self->MTVC  = m;
}

-(NSArray *)arrFromArrDict: (NSArray<NSDictionary *> *) d withKey: (NSString *) key
{
    NSMutableArray   *arr =  [NSMutableArray array];
    for (NSInteger i = 0; i < d.count; i++)
    {
        [arr addObject: [d objectAtIndex: i][key]];
    }
    
    return arr;
}


- (IBAction)btnClick:(id)sender
{
   /*
    
    //  Set Identifier and Table Data Source
    self.MyVCFilms.tableView.identifier       = @"films";
    self.MyVCGenres.tableView.identifier      = @"genres";
    self.MyVCDirectors.tableView.identifier   = @"directors";
    
    */
    
    
    
    if(sender  == btnAdd)
    {
        
        /////////////////// ********       Добавление строки  **************************
        NSTableView    *TV   = self.tableView;
        NSLog(@" Вносим данные в базу  и TableView : %@", TV);
        //TV.tableColumns.count
        if([TV.identifier isEqualToString: @"films"])
        {
            self->MORV = [[MyOneRowView  alloc]  initWithNibName: @"MyOneRowView" bundle: nil ]; // operationType: false editValues: nil];
            
            
            [self->MORV  presentViewControllerAsModalWindow: self->MORV];
            self->MORV.tableName  = TV.identifier.copy;
            self->MORV.isEditNotAdd = NO;
            self->MORV.selectedId   =  -1;
            self->MORV.view.window.styleMask =   NSTitledWindowMask ;
            self->MORV.view.window.title =  @"Добавление фильма" ;
            
            //NSWindowStyleMaskBorderless;
          //  NSLog(@"self->MORV.filmGenreCombo = %@\n self->MORV.filmDirectorCombo = %@", self->MORV.filmGenreCombo, self->MORV.filmDirectorCombo);
            
            
            
            
            [self->MORV.filmGenreCombo  addItemsWithObjectValues: [self arrFromArrDict:self->MTVC.genres withKey: @"genresName"]   ];
            [self->MORV.filmDirectorCombo  addItemsWithObjectValues: [self arrFromArrDict:self->MTVC.directors withKey: @"directorsName"] ];
            
        }
        if([TV.identifier isEqualToString: @"genres"])
        {
            self->MORV = [[MyOneRowView  alloc]  initWithNibName: @"MyOneRowViewGenre" bundle: nil ] ; //operationType: false editValues: nil];
            [self->MORV  presentViewControllerAsModalWindow: self->MORV];
            self->MORV.tableName  = TV.identifier.copy;
            self->MORV.isEditNotAdd = NO;
            self->MORV.selectedId   =  -1;
            self->MORV.view.window.styleMask =   NSTitledWindowMask ;
            self->MORV.view.window.title =  @"Добавление жанра" ;
            
        }
        if([TV.identifier isEqualToString: @"directors"])
        {
            self->MORV = [[MyOneRowView  alloc]  initWithNibName: @"MyOneRowViewDirector" bundle: nil ] ; //operationType: false editValues: nil];
            [self->MORV  presentViewControllerAsModalWindow: self->MORV];
            self->MORV.tableName  = TV.identifier.copy;
            self->MORV.isEditNotAdd = NO;
            self->MORV.selectedId   =  -1;
            self->MORV.view.window.styleMask =   NSTitledWindowMask ;
            self->MORV.view.window.title =  @"Добавление режиссера" ;

        }
        else
        {
            NSLog(@"MyVC Add Табличный идентификатор не подошел");
        }
        
    }
    else if(sender  == btnDel)
    {
        /////////////////// ********        Удаление строки  **************************
        
        NSTableView    *TV   = self.tableView;
        NSLog(@" Удаляем данные из базы  и TableView : %@", TV);
        if([TV  selectedRow] != -1)
        {
            [self->MTVC   deleteRow:[TV  selectedRow] tableIdentifier: TV.identifier];
            [TV reloadData];
        }
        else
        {
            //NSAlert не выбрана строка
            NSLog(@"Не выбрана строка");
            NSAlert    *alert       = [NSAlert  new];
            alert.messageText       = @"Внимание!";
            alert.informativeText   = @"Не выбрана строка для удаления!";
            alert.alertStyle        = NSWarningAlertStyle;
            
            [alert runModal];
        }
    }
    else if(sender  == btnEdt)
    {
        /////////////////// ********        Редактирование строки  **************************
        
        NSTableView    *TV   = self.tableView;
        NSLog(@" Редактируем  данные в базе  и TableView : %@, identifier = %@", TV, TV.identifier);
        
        
        if( [TV selectedRow] != -1)
        {
            NSDictionary     *dict = nil;
            // NSLog(@"%@", dict);
            if([TV.identifier isEqualToString: @"films"])
            {
                
                dict =  [self->MTVC   getRowAtIndex: (int)[TV  selectedRow]];
                
                self->selectedId  =   [dict[@"id"] intValue];
                
                self->MORV = [[MyOneRowView  alloc]  initWithNibName: @"MyOneRowView" bundle: nil] ; //operationType: false editValues: nil];
                [self->MORV  presentViewControllerAsModalWindow: self->MORV];
                self->MORV.tableName  = TV.identifier.copy;
                self->MORV.isEditNotAdd = YES;
                self->MORV.selectedId   =  self->selectedId;
                self->MORV.view.window.styleMask =   NSTitledWindowMask ;
                self->MORV.view.window.title =  @"Изменение фильма" ;
                [self->MORV.filmGenreCombo  addItemsWithObjectValues: [self arrFromArrDict:self->MTVC.genres withKey: @"genresName"]   ];
                [self->MORV.filmDirectorCombo  addItemsWithObjectValues: [self arrFromArrDict:self->MTVC.directors withKey: @"directorsName"] ];
                
                self->MORV.filmName.stringValue = [dict[@"filmsName"] copy];
                self->MORV.filmGenreCombo.stringValue = [dict[@"filmsGenre"] copy];
                self->MORV.filmDirectorCombo.stringValue = [dict[@"filmsDirector"] copy];
            }
            else if([TV.identifier isEqualToString: @"genres"])
            {
                
               dict =  [self->MTVC.genres  objectAtIndex:[TV  selectedRow]];
                
                self->selectedId  =   [dict[@"id"] intValue];

                
                self->MORV = [[MyOneRowView  alloc] initWithNibName: @"MyOneRowViewGenre" bundle: nil ]; // operationType: false editValues: nil];
                [self->MORV  presentViewControllerAsModalWindow: self->MORV];
                self->MORV.tableName  = TV.identifier.copy;
                self->MORV.isEditNotAdd = YES;
                self->MORV.selectedId   =  self->selectedId;
                self->MORV.view.window.styleMask =   NSTitledWindowMask ;
                self->MORV.view.window.title =  @"Изменение жанра" ;
                self->MORV.genre.stringValue = [[self->MTVC.genres objectAtIndex: [TV selectedRow]] [@"genresName"] copy];
            }
            else if([TV.identifier isEqualToString: @"directors"])
            {
                
                dict =  [self->MTVC.directors  objectAtIndex:[TV  selectedRow]];
                
                self->selectedId  =   [dict[@"id"] intValue];

                
                self->MORV = [[MyOneRowView  alloc]  initWithNibName: @"MyOneRowViewDirector" bundle: nil]; // operationType: false editValues: nil];
                [self->MORV  presentViewControllerAsModalWindow: self->MORV];
                self->MORV.tableName  = TV.identifier.copy;
                self->MORV.isEditNotAdd = YES;
                self->MORV.selectedId   =  self->selectedId;
                self->MORV.view.window.styleMask =   NSTitledWindowMask ;
                self->MORV.view.window.title =  @"Изменение режиссера" ;
                self->MORV.director.stringValue = [[self->MTVC.directors objectAtIndex: [TV selectedRow]] [@"directorsName"] copy];
            }
            else
            {
                NSLog(@"MyVc Edit Табличный идентификатор не подошел");
            }

            
            
//            self->MORV.name.stringValue   =  [dict[@"name"] copy];
//            
//            self->MORV.weight.stringValue   = [NSString   stringWithFormat:@"%i",[dict[@"weight"] intValue] ];
//            self->MORV.price.stringValue   =  [NSString   stringWithFormat:@"%5.2lf",[dict[@"price"] doubleValue] ];
            //            [self->MTVC   editRow: dict];
            //            [self->tableView reloadData];
        }
        else
        {
            //NSAlert не выбрана строка
            NSLog(@"Не выбрана строка для редктирования");
            NSAlert    *alert       = [NSAlert  new];
            alert.messageText       = @"Внимание!";
            alert.informativeText   = @"Не выбрана строка для редактирования!";
            alert.alertStyle        = NSWarningAlertStyle;
            
            [alert runModal];
        }
        
        
    }
}


-(void)clearTableView
{
    NSArray     *arr   = self.tableView.tableColumns;
    for (NSInteger i = arr.count - 1   ;  i >= 0; i--)
    {
        [self.tableView removeTableColumn: [arr objectAtIndex: i]];
    }
}

-(void)createTableColumnsWithDictionary: (NSDictionary *) dict
{
    for (NSInteger i = 0; i < dict.count / 2; i++)
    {
        NSString   *keyId    =   [NSString stringWithFormat:@"%liid",i];
        NSString   *keyTitle    =   [NSString stringWithFormat:@"%lititle",i];
        
        NSString  *identifierTC = [dict[keyId] copy];
        NSString  *titleTC = [dict[keyTitle] copy];
      //  NSLog(@"identifier = %@ title = %@", identifierTC, titleTC);
        
        NSTableColumn   *TC   =   [[NSTableColumn  alloc] initWithIdentifier: identifierTC];
        TC.title    = titleTC;
        TC.headerCell.stringValue   = titleTC;
        TC.resizingMask  = NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask;
        TC.width  = 150;
        if([titleTC  isEqualToString:@"Название"])
        {
           TC.width  = 250;
        }
       // NSLog(@"TC= %@", TC);
        [self.tableView  addTableColumn: TC];
      //  NSLog(@"TC= %@, self.tableView = %@", TC, self.tableView);
        
      //  NSLog(@"%@", self.tableView.tableColumns);
    }
    // NSLog(@"%@", self.tableView.tableColumns);
    [self.tableView  reloadData];
    self.tableView.needsDisplay = YES;
}


//-(void)tableView:  (NSTableView *)    AddColumnWithIdentifier:


@end