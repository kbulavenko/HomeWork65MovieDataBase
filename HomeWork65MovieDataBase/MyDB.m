//
//  MyDB.m
//  HomeWork65MovieDataBase
//
//  Created by  Z on 15.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyDB.h"
#import "Movies.h"

@implementation MyDB
@synthesize db;


- (instancetype)initWithPath: (NSString *)  p
{
    self = [super init];
    if (self != nil)
    {
        self->db = [FMDatabase databaseWithPath: p];
        if(self->db != nil)
        {
            if([self->db open] == NO)
                return nil;
        }
        else
        {
            return nil;
        }
        
    }
    return self;
}


-(void)makeDBWithNum: (NSInteger) num
{
    if(num <=0 )  return;
    
    NSString   *createFilms = @"CREATE TABLE IF NOT EXISTS films ( id integer not null primary key autoincrement, name text, id_genre integer,      id_director     integer,  FOREIGN KEY  (id_genre)  REFERENCES    genres (id) ON DELETE     NO ACTION  ON UPDATE       CASCADE, FOREIGN KEY  (id_director)  REFERENCES    directors (id)  ON DELETE     NO ACTION      ON UPDATE      CASCADE      );   ";
    NSString   *createGenres = @"CREATE TABLE  IF NOT EXISTS genres (id integer not null primary key autoincrement, genresName text);";
    NSString   *createDirectors = @"CREATE TABLE  IF NOT EXISTS directors (id integer not null primary key autoincrement, directorsName text);";
    
    NSString   *dropFilmsIfExists  = @"DROP TABLE  IF EXISTS films";
    NSString   *dropGenresIfExists  = @"DROP TABLE  IF EXISTS genres";
    NSString   *dropDirectorsIfExists  = @"DROP TABLE  IF EXISTS directors";
    
    [self->db executeUpdate: dropFilmsIfExists];
    [self->db executeUpdate: dropGenresIfExists];
    [self->db executeUpdate: dropDirectorsIfExists];
    [self->db executeUpdate: createFilms];
    [self->db executeUpdate: createGenres];
    [self->db executeUpdate: createDirectors];
    int genresCount = 0;
    NSString   *strInsert  = @"INSERT INTO genres (genresName) VALUES (%@);";
    while (true)
    {
        if(genreByNumber(genresCount) == nil)
            break;
        NSString    *str   = genreByNumber(genresCount).copy;
        [self->db executeUpdateWithFormat: strInsert, str];
        genresCount++;
    }
    
    int  directorsCount = 0;
    strInsert  = @"INSERT INTO directors (directorsName) VALUES (%@);";
    while (true)
    {
        if(directorByNumber(directorsCount) == nil)
            break;
        NSString    *str   = directorByNumber(directorsCount).copy;
        [self->db executeUpdateWithFormat: strInsert, str];
        directorsCount++;
    }
    
    strInsert  = @"INSERT INTO films (name, id_genre, id_director) VALUES (%@ , %i, %i);";
    NSString   *strInsertBuf  = @"INSERT INTO films (name, id_genre, id_director) VALUES (\'%@\' , %i, %i);";
    
    NSMutableArray<NSString *>    *bufferWriting = [NSMutableArray<NSString *>  array];
    
    NSInteger  stop = (num >= 300000)? 30000 :(num >= 100000)? 10000 : (num >= 10000)? 1000 : (num >= 1000)? 100 : 10 ;
    
    //NSString *nameFilm;
    NSLog(@"Start DB writing cycle");
   
    /*
    
    
    for (int i = 0; i < num; i++)
    {
        NSString *nameFilm = randomMovie().copy;
        int       idDirector  = rand() % (directorsCount +1 );
        int       idGenre  = rand() % (genresCount + 1 );
        if( ! [self->db executeUpdateWithFormat: strInsert, nameFilm, idDirector, idGenre ])
        {
            NSLog(@"%@", self->db.lastError);
        }
    }
    */
    
    for (int i = 1; i <= num; i++)
    {
        NSString *nameFilm = randomMovie().copy;
        int       idDirector  = 1+ rand() % (directorsCount  );
        int       idGenre  = 1 + rand() % (genresCount  );
        [bufferWriting  addObject: [NSString stringWithFormat: strInsertBuf,nameFilm, idGenre, idDirector]];
        
        
        
        if(bufferWriting.count % stop == 0)
        {
            NSLog(@"i = %i",i);
           // [self.db  beginTransaction];
            for (NSInteger i = 0; i < bufferWriting.count; i++)
            {
               
                if( ! [self->db executeUpdateWithFormat: [bufferWriting objectAtIndex: i]])
               {
                   NSLog(@"%@", self->db.lastError);
               }
                

            }
           // [self.db  commit];
            
            bufferWriting = [NSMutableArray<NSString *>  array];
        }
        
        
        
        
    }
    NSLog(@"Next cycle beginning bufferWriting.count = %li", bufferWriting.count);
    [self.db  beginTransaction];

    for (NSInteger i = 0; i < bufferWriting.count; i++)
    {
        
        if(![self->db executeUpdateWithFormat: [bufferWriting objectAtIndex: i]])
        {
            NSLog(@"%@", self->db.lastError);
        }


    }
     [self.db  commit];
    bufferWriting = [NSMutableArray<NSString *>  array];
    
    
    NSLog(@"END base writing. Base.count = %li", [self getFilmsCount]);
    
    NSLog(@"\n\n");
    
   // [self showFilms];
    
    NSLog(@"\n\n");
 //   [self showGenres];
    NSLog(@"\n\n");
  //  [self showDirectors];
    
    NSLog(@"\n\n");
   // [self showFilmsWithGenresAndDirectors];
    NSLog(@"\n\n");
    
}



-(void)showFilmsWithGenresAndDirectors
{
    FMResultSet	*result = [db executeQuery : @"SELECT films.name, genres.genresName, directors.directorsName FROM films, genres, directors WHERE films.id_genre = genres.id AND films.id_director = directors.id;"];
    while([result next])
    {
        NSLog(@"Film  \t%30@ \t\t\t%@ \t%@.",
              [result stringForColumn : @"name"],
              [result stringForColumn : @"genresName"],
              [result stringForColumn : @"directorsName"]);
    }
    [result close];
    
    
}


-(void)showFilms
{
    FMResultSet	*result = [db executeQuery : @"SELECT * FROM films"];
    while([result next])
    {
        NSLog(@"Film with ID : \t%i \tis \t%30@ \t\t%i \t%i.",
              [result intForColumn : @"id"],
              [result stringForColumn : @"name"],
              [result intForColumn : @"id_genre"],
              [result intForColumn : @"id_director"]);
    }
    [result close];
   
    
}


-(void)showGenres
{
    FMResultSet  *result = [db executeQuery : @"SELECT * FROM genres"];
    while([result next])
    {
        NSLog(@"Genre with ID : \t%i \tis \t%24@ .",
              [result intForColumn : @"id"],
              [result stringForColumn : @"genresName"]
              );
    }
    [result close];

}

-(void)showDirectors
{
    FMResultSet  *result = [db executeQuery : @"SELECT * FROM directors"];
    while([result next])
    {
        NSLog(@"Genre with ID : \t%i \tis \t%24@ .",
              [result intForColumn : @"id"],
              [result stringForColumn : @"directorsName"]
              );
    }
    [result close];
}


-(NSMutableArray<NSDictionary *> *) getFilms
{
    NSMutableArray<NSDictionary *> *arr  = [NSMutableArray  array];
    NSString    *selectStr = @"SELECT films.name, genres.genresName, directors.directorsName FROM films, genres, directors WHERE films.id_genre = genres.id AND films.id_director = directors.id;";
    
    FMResultSet  *result   =  [self->db executeQuery:   selectStr];
    while ([result next])
    {
        NSDictionary *dict  =  @{ @"filmsName"     :   ([result stringForColumn      : @"name"]),
                                  @"filmsGenre"   :   [result stringForColumn     : @"genresName"],
                                  @"filmsDirector" :   ([result stringForColumn      : @"directorsName"])
                                  };
        [arr  addObject: dict];
       //  NSLog(@"dict = %@", dict);
        
    }
    [result close];

    
    return arr;
}



-(NSMutableArray<NSDictionary *> *) getGenres
{
    NSMutableArray<NSDictionary *> *arr  = [NSMutableArray  array];
    NSString    *selectStr = @"SELECT * FROM genres;";
    
    FMResultSet  *result   =  [self->db executeQuery:   selectStr];
    while ([result next])
    {
        NSDictionary *dict  =  @{ @"genresName"     :   ([result stringForColumn      : @"genresName"])
                                  };
        [arr  addObject: dict];
      //  NSLog(@"dict = %@", dict);
        
    }
    [result close];
    
    
    return arr;
}




-(NSMutableArray<NSDictionary *> *) getDirectors
{
    NSMutableArray<NSDictionary *> *arr  = [NSMutableArray  array];
    NSString    *selectStr = @"SELECT * FROM directors;";
    
    FMResultSet  *result   =  [self->db executeQuery:   selectStr];
    while ([result next])
    {
        NSDictionary *dict  =  @{ @"directorsName"     :   ([result stringForColumn      : @"directorsName"]),
                                  };
        [arr  addObject: dict];
      //  NSLog(@"dict = %@", dict);
        
    }
    [result close];
    
    
    return arr;
}


-(NSMutableArray<NSDictionary *> *) getFilmsFromStart: (NSInteger) startRow numRow: (NSInteger) numRow
{
    NSMutableArray<NSDictionary *> *arr  = [NSMutableArray  array];
  //  NSInteger     filmsCount  = [self getFilmsCount];
//    if(startRow + numRow >=  filmsCount)
//    {
//        numRow = filmsCount - 1 -startRow;
//        NSLog(@"numRow = %li", numRow);
//    }
  //  NSLog(@"getFilmsFromStart startRow = %li numRow = %li", numRow, startRow);
    NSString    *selectStr = @"SELECT films.id AS fd,films.name AS fN, genres.genresName AS gN, directors.directorsName AS dN  FROM films, genres, directors WHERE films.id_genre = genres.id AND films.id_director = directors.id LIMIT ?, ?;";
    
    FMResultSet  *result   =  [self->db executeQuery:   selectStr, @(startRow), @(numRow)];
    while ([result next])
    {
        NSDictionary *dict  =  @{ @"filmsName"     :   ([result stringForColumn      : @"fN"]),
                                  @"filmsGenre"   :   [result stringForColumn     : @"gN"],
                                  @"filmsDirector" :   ([result stringForColumn      : @"dN"]),
                                  @"filmsId" :   @([result longForColumn      : @"fd"])
                                  };
        [arr  addObject: dict];
        //  NSLog(@"dict = %@", dict);
        
    }
    [result close];
    if(arr.count == 0) {
        NSLog(@"!!!!!!!!!!!!!!!!!!     Из базы идет нулевой массив");
//        for (NSInteger i = 0; i < numRow; i++)
//        {
//            
//            
//            NSDictionary *dict  =  @{ @"filmsName"     :  @" ",
//                                      @"filmsGenre"   :   @"  ",
//                                      @"filmsDirector" :   @"   "
//                                      };
//            [arr addObject: dict];
//        }

    }
    
    return arr;
}

-(NSInteger)getFilmsCount
{
    NSUInteger   retValue = 0;
   // NSString    *selectStr =  @"SELECT  COUNT(*) AS cnt FROM  (SELECT films.name , genres.genresName , directors.directorsName  FROM films, genres, directors WHERE films.id_genre = genres.id AND films.id_director = directors.id )  filmsAll;";
    
    NSString    *selectStr =  @"SELECT  COUNT(*) AS cnt FROM  films;";
    
    
    FMResultSet *result  =  [self->db executeQuery: selectStr];
    if([result next])
    {
    retValue = [result longForColumn:@"cnt"];
    }
  //  NSLog(@"retValue = %li", retValue);
    if(retValue == 0) exit (1);
    return retValue;
}

-(void)dbReopen
{
    [self.db close];
    [self.db open];
}

-(void)dealloc
{
    NSLog(@"MyDB Dealloc");
    [self->db close];
    
}


@end
