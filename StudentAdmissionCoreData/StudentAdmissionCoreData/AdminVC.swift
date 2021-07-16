//
//  AdminVC.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import UIKit

class AdminVC: UIViewController {
    
    private let wlcmlbl:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Welcome Admin"
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .red
        myLabel.font = .boldSystemFont(ofSize: 25)
        return myLabel
    }()
    
    private let selectlbl:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Options"
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        return myLabel
    }()
    
    private let StudentDetails : UIButton = {
        let btn = UIButton()
        btn.setTitle("StudentDetails", for: .normal)
        btn.backgroundColor = .purple
        btn.addTarget(self, action: #selector(StudentDetail), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        
        return btn
    } ()
    
    @objc private func StudentDetail()
    {
        let vc = StudentListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private let NoticeBoard : UIButton = {
        let btn = UIButton()
        btn.setTitle("NoticeBoard", for: .normal)
        btn.backgroundColor = .purple
        btn.addTarget(self, action: #selector(NoticeBoards), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        return btn
    } ()
    
    @objc private func NoticeBoards()
    {
        let vc = NoticeBoardVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Admin Panel"
        view.addSubview(wlcmlbl)
        view.addSubview(selectlbl)
        view.addSubview(StudentDetails)
        view.addSubview(NoticeBoard)
        
        self.view.backgroundColor = .blue
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        wlcmlbl.frame = CGRect(x: 0, y: 100, width: view.width, height: 80)
        selectlbl.frame = CGRect(x: 0, y: wlcmlbl.bottom + 10, width: view.width, height: 40)
        StudentDetails.frame = CGRect(x: 100, y: selectlbl.bottom + 20, width: view.width / 2, height: 80)
        NoticeBoard.frame = CGRect(x: 100, y: StudentDetails.bottom + 20, width: view.width / 2, height: 80)
    }
    
}
