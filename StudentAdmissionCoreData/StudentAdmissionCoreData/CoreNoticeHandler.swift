//
//  CoreNoticeHandler.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreNoticeHandler
{
    static let shared = CoreNoticeHandler() // single instance
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate // to go to Appdelegate "Save function " we have to do this in order to link it or acces  the function
    let managedObjectContext: NSManagedObjectContext?
    
    private init()
    {
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save()
    {
        appDelegate.saveContext() //calling the save function from app delegate
    }
    
    func insert(notice:String, completion: @escaping () -> Void)
    {
        let nt = Notice(context: managedObjectContext!)
        nt.notice = notice
        
        save()
        completion()
    }
    func update(not:Notice,notice:String, completion: @escaping () -> Void)
    {
        not.notice = notice
        
        save()
        completion()
    }
    /*func delete(stud:Student, completion: @escaping () -> Void)
     {
     managedObjectContext!.delete(stud)
     save()
     completion()
     }*/
    func fetch() -> [Notice]
    {
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        
        do
        {
            let noticeArray = try managedObjectContext?.fetch(fetchRequest)
            return noticeArray!
        } catch {
            print(error)
            let noticeArray = [Notice]()
            return noticeArray // to prevent the app from crashing so we are reurning empty array
        }
    }
    
    
    
}
