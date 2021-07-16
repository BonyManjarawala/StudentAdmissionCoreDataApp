//
//  CoreDataHandler.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler
{
    static let shared = CoreDataHandler() // single instance
    
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
    
    func insert(spid:String ,name:String ,div:String , pwd:String, completion: @escaping () -> Void)
    {
        let stud = Student(context: managedObjectContext!)
        stud.spid = spid
        stud.name = name
        stud.div = div
        stud.pwd = pwd
        
        save()
        completion()
    }
    func update(stud:Student ,spid:String ,name:String ,div:String , pwd:String, completion: @escaping () -> Void)
    {
        stud.spid = spid
        stud.name = name
        stud.div = div
        stud.pwd = pwd
        
        save()
        completion()
    }
    
    func updatepwd(stud:Student , pwd:String, completion: @escaping () -> Void)
    {
        stud.pwd = pwd
        
        save()
        completion()
    }
    func delete(stud:Student, completion: @escaping () -> Void)
    {
        managedObjectContext!.delete(stud)
        save()
        completion()
    }
    func fetch() -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do
        {
            let studArray = try managedObjectContext?.fetch(fetchRequest)
            
            return studArray!
        } catch {
            print(error)
            let studArray = [Student]()
            return studArray // to prevent the app from crashing so we are reurning empty array
        }
    }
    
    
    
}
