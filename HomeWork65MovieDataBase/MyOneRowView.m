//
//  MyOneRowView.m
//  HomeWork62ProductsDB
//
//  Created by Z on 09.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyOneRowView.h"

@interface MyOneRowView ()

@end

@implementation MyOneRowView
@synthesize filmName, filmGenreCombo, filmDirectorCombo, genre ,director , btnOk, btnCancel, readResult, tableName, isEditNotAdd, selectedId;


//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType: (BOOL) ot  editValues: (NSDictionary *) ev
//
//{
//    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
//    if (self != nil)
//    {
//        self->isOperationEdit   = ot;
//        self->editValues        = ev;
//        
//        if(self->isOperationEdit )
//        {
//          //  NSLog(@"ev = %@", ev);
//          //  self->name.stringValue   = [ self->editValues[@"name"] copy];
//          //  self->weight.stringValue   = [ self->editValues[@"weight"] copy];
//          //  self->price.stringValue   = [ self->editValues[@"price"] copy];
//            //NSLog(@"self->editValues[@\"name\"] =  %@", self->editValues[@"name"]);
//            
//            
//        }
//        
//    }
//    return self;
//
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
   // self.name.stringValue   = @"";
    NSLog(@"MyOneRowView viewDidLoad");
    self->filmGenreCombo.usesDataSource = false;
    self->filmDirectorCombo.usesDataSource = false;
    self->readResult = [NSDictionary  dictionary];
    
}

- (IBAction)btnClick:(id)sender
{
    ///
    if(sender == btnOk)
    {
       
      //  NSLog(@"[self->filmGenreCombo objectValues] %@", [self->filmGenreCombo objectValues]);
      //  NSLog(@"[self->filmDirectorCombo objectValues] %@", [self->filmDirectorCombo objectValues]);
        
        
        // [self      removeFromParentViewController];
        
        if( ( [self.tableName isEqualToString:@"films"] &&
            ( self.filmName.stringValue.length == 0 ||
             self.filmGenreCombo.stringValue.length == 0 ||
             self.filmDirectorCombo.stringValue.length == 0))
           || ([self.tableName isEqualToString:@"genres"] &&
               ( self.genre.stringValue.length == 0 ))
           || ([self.tableName isEqualToString:@"directors"] &&
               ( self.director.stringValue.length == 0 )))
        {
            NSAlert   *alert  = [NSAlert  new];
            alert.messageText   = @"Ошибка!";
            alert.informativeText  = @"Данные введены неверно!";
            alert.alertStyle    = NSCriticalAlertStyle;
            [alert runModal];
            
            return;
        }
        
        NSString   *action  = (self.isEditNotAdd)?@"Edit":@"Add";
        
        NSString   *filmsName  = (self.filmName.stringValue.copy == nil )? @"_1" : self.filmName.stringValue.copy;
        NSString   *filmsGenre  = (self.filmGenreCombo.stringValue.copy == nil )? @"_2" : self.filmGenreCombo.stringValue.copy;
        NSString   *filmsDirector  = (self.filmDirectorCombo.stringValue.copy == nil )? @"_3" :self.filmDirectorCombo.stringValue.copy;
        NSString   *genresName  = (self.genre.stringValue.copy == nil )? @"_4" : self.genre.stringValue.copy;
        NSString   *directorsName  = (self.director.stringValue.copy == nil )? @"_5" : self.director.stringValue.copy;
        
//        
//       NSDictionary *dict =   @{
//                                 @"filmsName"           :   filmsName,
//                                 @"filmsGenre"          :   filmsGenre,
//                                 @"filmsDirector"       :   filmsDirector,
//                                 @"genresName"          :   genresName,
//                                 @"directorsName"       :   directorsName,
//                                 @"tableName"           :   self.tableName.copy,
//                                 @"action"              :   action
//                                 };
        
        self->readResult   =   @{
                                 @"filmsName"           :   filmsName,
                                 @"filmsGenre"          :   filmsGenre,
                                 @"filmsDirector"       :   filmsDirector,
                                 @"genresName"          :   genresName,
                                 @"directorsName"       :   directorsName,
                                 @"tableName"           :   self.tableName.copy,
                                 @"action"              :   action,
                                 @"id"                  :   @(self.selectedId)
                                 };
//        if(self.selectedId != -1)
//        {
//            [self.readResult set: [NSString stringWithFormat:@"%li", self.selectedId] forKey:@"id"];
//        }
        
        
        NSLog(@"Begin Notification");
        NSNotificationCenter    *NC  =   [NSNotificationCenter defaultCenter];
        
        
        [NC   postNotificationName: MyOneRowViewDataReadyUpdateNotification object: nil   userInfo: self->readResult];
        NSLog(@" Begin [self.view.window close];");
        [self.view.window close];
     //   [self.view removeFromSuperview];
     //   [self      removeFromParentViewController];

    }
    else
    if(sender == btnCancel)
    {
        [self.view.window close];
    //    [self.view removeFromSuperview];
    //    [self      removeFromParentViewController];
    }
}




@end
