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
    NSLog(@"-- START MTVC   initWithDB");
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
            self->countRows = (dbCount >= 100000) ? 5000  :(dbCount >= 10000) ?  1000 :  (dbCount >= 100) ?  100 : 100 /*dbCount - 1 */;
            
              if( BUFFEREDTV == NO )    self->films  = [self->myDB getFilms];
            //  if(BUFFEREDTV == YES)  self->filmsBuffer   = [self->myDB getFilmsFromStart: 0 numRow: self->countRows];
            self.genres  = [self.myDB getGenres];
            self.directors  = [self.myDB getDirectors];
        }
    }
    NSLog(@"-- END initWithDB");
    return self;
    
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
   // NSLog(@"numberOfRowsInTableView tableView (%@).identifier = %@",tableView, tableView.identifier);
    if([ tableView.identifier isEqualToString: @"films"])
    {
        
        if(BUFFEREDTV == YES){
            NSInteger    num   =[self->myDB  getFilmsCount];
            NSLog(@"[self->myDB  getFilmsCount]  =  %li", num);
            return num ;
        }
        if(BUFFEREDTV == NO)   return films.count;
    }
    else if([ tableView.identifier isEqualToString: @"genres"])
    {
        return genres.count;
    }
    else if([ tableView.identifier isEqualToString: @"directors"])
    {
        return directors.count;
    }
    return  1;
}

- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
   // NSLog(@"objectValueForTableColumn  tableColumn.identifier = %@", tableColumn.identifier);
    
    
    if([ tableView.identifier isEqualToString: @"films"])
    {
        NSDictionary	*dictFilm;
        
        if( BUFFEREDTV == YES )
        {
            dictFilm	= [self getRowAtIndex : row ];
             if(dictFilm == nil)  return @"NIL!!! ???";
            return dictFilm[tableColumn.identifier]  ;

        }
        else  if( BUFFEREDTV == NO )     return [films objectAtIndex: row][tableColumn.identifier]  ;
    }
    else if([ tableView.identifier isEqualToString: @"genres"])
    {
      //  NSLog(@"[genres objectAtIndex: row = %li][tableColumn.identifier = %@] = %@", row,tableColumn.identifier,[genres objectAtIndex: row][tableColumn.identifier]);
        return ([genres objectAtIndex: row][tableColumn.identifier] == nil)? @"NIL ????" : [genres objectAtIndex: row][tableColumn.identifier] ;
    }
    else if([ tableView.identifier isEqualToString: @"directors"])
    {
       // return  [directors objectAtIndex: row][tableColumn.identifier];   // == nil)? @"Direct_NIL????" :[directors objectAtIndex: row][tableColumn.identifier] ;
        return ( [directors objectAtIndex: row][tableColumn.identifier] == nil)? @"Direct_NIL????" :[directors objectAtIndex: row][tableColumn.identifier] ;
    }
    return	@"N/A";
}


-(NSDictionary*) getRowAtIndex  : (NSInteger) index
{
    //   Проверки:
    // 1. Запрашиваема строка ВООБЩЕ не из буфера
    // 2. Запрашиваема строка НЕ ИЗ ЦЕНТРА БУФЕРА
   // NSLog(@"getRowAtIndex index = %li", index);
    if(index < self->startRow || index >= self->startRow + self->countRows)
    {
        [self reloadBuffer: index - (index % self->countRows)];
    }
    return [self->filmsBuffer  objectAtIndex: index  - self->startRow];
    
}

-(void) reloadBuffer  : (NSInteger) startIndex
{
 //   NSLog(@"   START reloadBuffer, startIndex = %li", startIndex);
    [self->filmsBuffer removeAllObjects];
   // self->filmsBuffer = [NSMutableArray<NSDictionary *> array];
     self->startRow  = startIndex;
    
    [self->filmsBuffer addObjectsFromArray: [self.myDB   getFilmsFromStart: self->startRow numRow: self->countRows]];
    
  //  NSLog(@"self->startRow = %li, self->filmsBuffer.count = %li", self->startRow, self->filmsBuffer.count);
  //  NSLog(@"   END reloadBuffer, startIndex = %li", startIndex);
}

-(void) deleteRow: (NSInteger) index tableIdentifier: (NSString *) ti
{
    
    NSDictionary    *dict  = nil;  //[self getRowAtIndex: index];
    if([ti isEqualToString:@"films"] )
    {
        dict  = [self getRowAtIndex: index];
        NSLog(@"MTVC.deleteRow dict = %@", dict);
       [self.myDB removeRow: dict tableName: ti];
        
       if(BUFFEREDTV == YES)    [self reloadBuffer: self->startRow];
        if(BUFFEREDTV == NO)     self->films = [self.myDB getFilms];
    }
    else if([ti isEqualToString:@"genres"] )
    {
        dict  = [self->genres  objectAtIndex: index];
        NSLog(@"MTVC.deleteRow dict = %@", dict);
        [self.myDB removeRow: dict tableName: ti];
        self->genres = [self.myDB getGenres];

    }
    else if([ti isEqualToString:@"directors"] )
    {
        dict  = [self.directors objectAtIndex: index];
        NSLog(@"MTVC.deleteRow dict = %@", dict);
        [self.myDB removeRow: dict tableName: ti];
        self->directors = [self.myDB getDirectors];
    }
    else
    {
        NSLog(@"Неверный идентификатор таблицы");
        return;
    }
}



-(void) addRow : (NSDictionary *) dict tableIdentifier: (NSString *) ti
{
/*    //    NSDictionary    *dict  = [self getRowAtIndex: index];
    [self->db executeUpdate: self->cmdInsert, [dict objectForKey:@"name"],[dict objectForKey:@"weight"],[dict objectForKey:@"price"]];
    //[self->arrRow removeObject: dict];
    [self reloadBuffer: self->startRow];
 */
    NSLog(@"--- MyTableViewController  addRow dict: %@, table : %@", dict, ti);
   
    
    [self->myDB addRow:dict tableName:ti];
    
    if([ti isEqualToString:@"films"] )
    {
        if(BUFFEREDTV == YES)    [self reloadBuffer:self->startRow];
        if(BUFFEREDTV == NO)     self->films = [self.myDB getFilms];
       
    }
    else if([ti isEqualToString:@"genres"] )
    {
        self->genres = [self.myDB getGenres];
    }
    else if([ti isEqualToString:@"directors"] )
    {
        self->directors = [self.myDB getDirectors];
    }
    else
    {
        NSLog(@"Неверный идентификатор таблицы");
        return;
    }

    
    
}

-(void) editRow: (NSDictionary *) dict tableIdentifier: (NSString *) ti
{
/*
    // NSDictionary    *dict  = [self getRowAtIndex: index];
    [self->db executeUpdate: self->cmdUpdate, [dict objectForKey:@"name"],[dict objectForKey:@"weight"],[dict objectForKey:@"price"],[dict objectForKey:@"id"]];
    //[self->arrRow removeObject: dict];
    [self reloadBuffer: self->startRow];
 
 */
    [self->myDB setRow: dict tableName:ti];
    if([ti isEqualToString:@"films"] )
    {
        if(BUFFEREDTV == YES)    [self reloadBuffer:self->startRow];
        if(BUFFEREDTV == NO)     self->films = [self.myDB getFilms];
        
    }
    else if([ti isEqualToString:@"genres"] )
    {
        self->genres = [self.myDB getGenres];
        if(BUFFEREDTV == YES)    [self reloadBuffer:self->startRow];
        if(BUFFEREDTV == NO)     self->films = [self.myDB getFilms];

    }
    else if([ti isEqualToString:@"directors"] )
    {
        self->directors = [self.myDB getDirectors];
        if(BUFFEREDTV == YES)    [self reloadBuffer:self->startRow];
        if(BUFFEREDTV == NO)     self->films = [self.myDB getFilms];

    }
    else
    {
        NSLog(@"Неверный идентификатор таблицы");
        return;
    }

}


@end
