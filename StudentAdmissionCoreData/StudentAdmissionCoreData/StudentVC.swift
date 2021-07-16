//
//  StudentVC.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import UIKit

class StudentVC: UIViewController {
    
    let spid = UserDefaults.standard.string(forKey: "spid")
    let name = UserDefaults.standard.string(forKey: "name")
    let div = UserDefaults.standard.string(forKey: "div")
    
    private var studArray = [Student]()
    private var noticeArray = [Notice]()
    
    private let welcomelbl:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let divlblnm:UILabel = {
        let label = UILabel()
        label.text = "Division"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    private let divlbl:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let noticenm:UILabel = {
        let label = UILabel()
        label.text = "Notice"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let noticelbl:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let changepwd : UIButton = {
        let pwd = UIButton()
        pwd.setTitle("Change Password", for: .normal)
        pwd.backgroundColor = .black
        pwd.addTarget(self, action: #selector(changepassword), for: .touchUpInside)
        pwd.layer.cornerRadius = 6
        return pwd
    } ()
    
    @objc private func changepassword()
    {
        //let stud = Student()
        let cnt = studArray.count
        for i in 0..<cnt
        {
            if (spid == studArray[i].spid!)
            {
                let stud = studArray[i]
                let alert = UIAlertController(title: "Add New Password", message: "Please Change Your Password", preferredStyle: .alert)
                
                alert.addTextField { (tf) in
                    tf.placeholder = "\(self.studArray[i].pwd!)"
                }
                let action = UIAlertAction(title:"Submit", style: .default) { (_) in
                    guard let pwd = alert.textFields?[0].text
                        else{
                            return
                    }
                    
                    CoreDataHandler.shared.updatepwd(stud: stud, pwd: pwd, completion: {
                        [weak self] in
                        print(self!.studArray[i].name!)
                        print(pwd)
                        let vc = StudentVC()
                        self?.navigationController?.pushViewController(vc, animated: false)
                    })
                }
                alert.addAction(action)
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        studArray = CoreDataHandler.shared.fetch()
        noticeArray = CoreNoticeHandler.shared.fetch()
        view.addSubview(welcomelbl)
        view.addSubview(divlblnm)
        view.addSubview(divlbl)
        view.addSubview(noticenm)
        view.addSubview(noticelbl)
        view.addSubview(changepwd)
        print(name!)
        print(div!)
        print(spid!)
        welcomelbl.text = "Welcome \(name!)"
        divlbl.text = div
        
        let ntcnt = noticeArray.count
        for i in 0..<ntcnt
        {
            noticelbl.text = noticeArray[i].notice
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        welcomelbl.frame = CGRect(x: 100, y: 100, width: 200, height: 80)
        divlblnm.frame = CGRect(x: 140, y: welcomelbl.bottom + 5, width: 100, height: 40)
        divlbl.frame = CGRect(x: 160, y: divlblnm.bottom, width: 70, height: 40)
        noticenm.frame = CGRect(x: 150, y: divlbl.bottom + 20, width: 90, height: 40)
        noticelbl.frame = CGRect(x: 90, y: noticenm.bottom, width: 290, height: 80)
        changepwd.frame = CGRect(x: 100, y: noticelbl.bottom + 20, width: view.width / 2, height: 80)
    }
    
    
    
}
