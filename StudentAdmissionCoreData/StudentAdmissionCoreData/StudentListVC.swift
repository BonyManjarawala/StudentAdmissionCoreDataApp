//
//  StudentListVC.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import UIKit
import UIKit

class StudentListVC: UIViewController {
    
    private var studArray = [Student]()
    
    private let studTable = UITableView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studArray = CoreDataHandler.shared.fetch()
        studTable.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Student"
        view.addSubview(studTable)
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewStudent))
        navigationItem.setRightBarButton(addItem, animated: true)
        
        setuptableview()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        studTable.frame = view.bounds
    }
    
    @objc private func addNewStudent()
    {
        let alert = UIAlertController(title: "Add Student", message: "Please Fill Down The Details", preferredStyle: .alert)
        /*alert.addTextField { (tf) in tf.placeholder = "name"}
         alert.addTextField { (tf) in tf.placeholder = "email"}*/
        alert.addTextField { (tf) in
            tf.placeholder = "SPID"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Name"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Division"
        }
        let action = UIAlertAction(title:"Submit", style: .default) { (_) in
            guard let spid = alert.textFields?[0].text,
                let name = alert.textFields?[1].text,
                let div = alert.textFields?[2].text
                else{
                    return
            }
            
            
            CoreDataHandler.shared.insert(spid: spid, name: name, div: div, pwd: spid) { [weak self] in
                print(spid)
                print(name)
                print(div)
                let vc = StudentListVC()
                self?.navigationController?.pushViewController(vc, animated: false)
                
            }
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
}
extension StudentListVC: UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stud", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.spid!) \t | \t \(stud.name!) \t | \t \(stud.div!) \t | \(stud.pwd!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let stud = studArray[indexPath.row] // passing reference for deleting
        CoreDataHandler.shared.delete(stud: stud) { [weak self] in
            
            self?.studArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        // delettion to be done
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let alert = UIAlertController(title: "Update Student", message: "Please Update The Details", preferredStyle: .alert)
        let stud = studArray[indexPath.row]
        
        alert.addTextField { (tf) in
            tf.text = "\(String(stud.spid!))"
        }
        alert.addTextField { (tf) in
            tf.text = "\(String(stud.name!))"
        }
        alert.addTextField { (tf) in
            tf.text = "\(String(stud.div!))"
        }
        alert.addTextField { (tf) in
            tf.text = "\(String(stud.pwd!))"
        }
        let action = UIAlertAction(title:"Submit", style: .default) { (_) in
            guard let spid = alert.textFields?[0].text,
                let name = alert.textFields?[1].text,
                let div = alert.textFields?[2].text,
                let pwd = alert.textFields?[3].text
                else{
                    return
            }
            
            CoreDataHandler.shared.update(stud: stud, spid: spid, name: name, div: div , pwd: pwd) { [weak self] in
                print(spid)
                print(name)
                print(div)
                let vc = StudentListVC()
                self?.navigationController?.pushViewController(vc, animated: false)
            }
            
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    private func setuptableview()
    {
        studTable.register(UITableViewCell.self, forCellReuseIdentifier: "stud")
        studTable.delegate = self
        studTable.dataSource = self
    }
    
    
}
