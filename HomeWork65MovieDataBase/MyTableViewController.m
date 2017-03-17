//
//  MyTableViewController.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController
@synthesize films, genres, directors, myDB;

- (instancetype)initWithDB: (MyDB *) db1
{
    self = [super init];
    if (self)
    {
        self->myDB   = db1;
        //[[MyDB  alloc] initWithPath: p];
        if(self->myDB == nil)
        {
            NSLog(@"Ошибка доступа к базе данных");
            return nil;
        }
        else
        {
           /////////////////////////////////////////////////////////////// [self.myDB makeDB];
            //self->films  = [NSMutableArray array];
            self->startRow  = 0;
            self->countRows = 500;
            
            //self->films  = [self->myDB getFilmsFromStart: self->startRow numRow: self->countRows];
    self->filmsBuffer   = [self->myDB getFilmsFromStart: self->startRow numRow: self->countRows];
           // self->genres  = [NSMutableArray   array];
           // self->directors  = [NSMutableArray   array];
            self.genres  = [self.myDB getGenres];
            self.directors  = [self.myDB getDirectors];
            
          //  NSLog(@"self.genres  = %@", self.genres);
        }
    }
    return self;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
   // NSLog(@"numberOfRowsInTableView tableView (%@).identifier = %@",tableView, tableView.identifier);
    
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        
        return [self->myDB  getFilmsCount];
        return films.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
        return genres.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return directors.count;
    }
    return  100;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"objectValueForTableColumn  tableColumn.identifier = %@", tableColumn.identifier);
    NSDictionary	*dictFilm	= [self getRowAtIndex : (int)row];
    
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        return dictFilm[tableColumn.identifier]  ;
        //return [films objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
      //  NSLog(@"[genres objectAtIndex: row = %li][tableColumn.identifier = %@] = %@", row,tableColumn.identifier,[genres objectAtIndex: row][tableColumn.identifier]);
        return [genres objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return [directors objectAtIndex: row][tableColumn.identifier]  ;
    }
    return	@"N/A";
}


-(NSDictionary*) getRowAtIndex  : (NSInteger) index
{
    //   Проверки:
    // 1. Запрашиваема строка ВООБЩЕ не из буфера
    // 2. Запрашиваема строка НЕ ИЗ ЦЕНТРА БУФЕРА
    
    if(index < self->startRow || index >= self->startRow + self->countRows)
    {
        [self reloadBuffer: index - (index % self->countRows)];
    }
    return [self->filmsBuffer  objectAtIndex: index  - self->startRow];
    
}

-(void) reloadBuffer  : (NSInteger) startIndex
{
   
    [self->filmsBuffer removeAllObjects];
     self->startRow  = startIndex;
    
    [self->filmsBuffer addObjectsFromArray: [self.myDB   getFilmsFromStart: startRow numRow: self->countRows]];

}



@end
