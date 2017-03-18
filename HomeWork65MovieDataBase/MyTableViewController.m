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
            self->films  = [NSMutableArray array];
            self->filmsBuffer  = [NSMutableArray array];
            
            self->startRow  = -5000;
            NSInteger   dbCount  = [self.myDB getFilmsCount];
            NSLog(@"[self.myDB getFilmsCount] = %li", dbCount);
            self->countRows = (dbCount >= 100000) ? 5000  :(dbCount >= 10000) ?  1000 : 100 ;
            
              if( BUFFEREDTV == NO )    self->films  = [self->myDB getFilms];
  // if(BUFFEREDTV == YES)  self->filmsBuffer   = [self->myDB getFilmsFromStart: 0 numRow: self->countRows];
            self.genres  = [self.myDB getGenres];
            self.directors  = [self.myDB getDirectors];
        }
    }
    return self;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
   // NSLog(@"numberOfRowsInTableView tableView (%@).identifier = %@",tableView, tableView.identifier);
    
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        
        if(BUFFEREDTV == YES)    return [self->myDB  getFilmsCount] ;
        if(BUFFEREDTV == NO)   return films.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
        return genres.count;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return directors.count;
    }
    return  1;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"objectValueForTableColumn  tableColumn.identifier = %@", tableColumn.identifier);
    NSDictionary	*dictFilm;
    
    if( BUFFEREDTV == YES )
    {
        dictFilm	= [self getRowAtIndex : row ];
       // if(dictFilm == nil)  return @"NIL!!! ???";
    }
    
    
    if([ tableView.identifier isEqualToString: @"TableViewIdFilms"])
    {
        if(BUFFEREDTV == YES)  if(dictFilm == nil)  return @"NIL!!! ???";

        
        if(BUFFEREDTV == YES)  return dictFilm[tableColumn.identifier]  ;
         if( BUFFEREDTV == NO )     return [films objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdGenres"])
    {
      //  NSLog(@"[genres objectAtIndex: row = %li][tableColumn.identifier = %@] = %@", row,tableColumn.identifier,[genres objectAtIndex: row][tableColumn.identifier]);
        return ([genres objectAtIndex: row][tableColumn.identifier] == nil)? @"NIL ????" : [genres objectAtIndex: row][tableColumn.identifier] ;
    }
    else if([ tableView.identifier isEqualToString: @"TableViewIdDirectors"])
    {
        return ( [directors objectAtIndex: row][tableColumn.identifier] == nil)? @"Direct_NIL????" :[directors objectAtIndex: row][tableColumn.identifier] ;
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
  //  NSLog(@"reloadBuffer, startIndex = %li", startIndex);
    //[self->filmsBuffer removeAllObjects];
    self->filmsBuffer = [NSMutableArray<NSDictionary *> array];
     self->startRow  = startIndex;
    
    [self->filmsBuffer addObjectsFromArray: [self.myDB   getFilmsFromStart: self->startRow numRow: self->countRows]];
  //  NSLog(@"self->startRow = %li, self->filmsBuffer.count = %li", self->startRow, self->filmsBuffer.count);
}

-(void) deleteRow: (NSInteger) index
{
    NSDictionary    *dict  = [self getRowAtIndex: index];
    [self->myDB.db executeUpdate: @"DELETE FROM films WHERE id = ?", [dict objectForKey:@"filmsId"]];
    //[self->arrRow removeObject: dict];
    [self reloadBuffer: self->startRow];
}



-(void) addRow : (NSDictionary *) dict
{
/*    //    NSDictionary    *dict  = [self getRowAtIndex: index];
    [self->db executeUpdate: self->cmdInsert, [dict objectForKey:@"name"],[dict objectForKey:@"weight"],[dict objectForKey:@"price"]];
    //[self->arrRow removeObject: dict];
    [self reloadBuffer: self->startRow];
 */
}

-(void) editRow: (NSDictionary *) dict
{
/*
    // NSDictionary    *dict  = [self getRowAtIndex: index];
    [self->db executeUpdate: self->cmdUpdate, [dict objectForKey:@"name"],[dict objectForKey:@"weight"],[dict objectForKey:@"price"],[dict objectForKey:@"id"]];
    //[self->arrRow removeObject: dict];
    [self reloadBuffer: self->startRow];
 */
}


@end
