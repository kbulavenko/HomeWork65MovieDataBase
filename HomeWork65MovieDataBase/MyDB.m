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


-(void)makeDB
{
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
    for (int i = 0; i < 100; i++)
    {
        NSString *nameFilm = randomMovie().copy;
        int       idDirector  = rand() % directorsCount;
        int       idGenre  = rand() % genresCount;
        [self->db executeUpdateWithFormat: strInsert, nameFilm, idGenre, idDirector];
        
    }
    NSLog(@"\n\n");
    
    [self showFilms];
    
    NSLog(@"\n\n");
    [self showGenres];
    NSLog(@"\n\n");
    [self showDirectors];
    
    NSLog(@"\n\n");
    [self showFilmsWithGenresAndDirectors];
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





-(void)dealloc
{
    [self->db close];
}


@end
