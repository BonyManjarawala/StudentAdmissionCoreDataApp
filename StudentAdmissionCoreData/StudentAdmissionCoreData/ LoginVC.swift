//
//   LoginVC.swift
//  StudentAdmissionCoreData
//
//  Created by DCS on 16/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    private let bgimage: UIImageView = {
        let bgimage = UIImageView()
        bgimage.image = UIImage(named: "vnsgu")
        return bgimage
    }()
    
    private let label :UILabel = {
        let label = UILabel()
        let font : UIFont = UIFont.boldSystemFont(ofSize: 30)
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "VNSGU"
        label.textAlignment = .center
        label.font = font
        label.textColor = .black
        return label
    }()
    
    private let username : UITextField = {
        
        let textView = UITextField()
        textView.placeholder = "Enter Username"
        textView.textAlignment = .center
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 70
        return textView
    }()
    
    private let password : UITextField = {
        
        let textView = UITextField()
        textView.placeholder = "Enter Password"
        textView.textAlignment = .center
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 70
        textView.isSecureTextEntry = true
        return textView
    }()
    
    private let vcbutton : UIButton = {
        let vc_button = UIButton()
        vc_button.setTitle("Login", for: .normal)
        vc_button.backgroundColor = .black
        vc_button.addTarget(self, action: #selector(redirect), for: .touchUpInside)
        vc_button.layer.cornerRadius = 50
        return vc_button
    } ()
    
    @objc func redirect()
    {
        
        
        if(username.text == "Admin" && password.text == "Admin")
        {
            let vc = AdminVC()
            navigationController?.pushViewController(vc, animated: true)
            UserDefaults.standard.setValue(username.text, forKey: "username")
            UserDefaults.standard.setValue("asdfgdewseds", forKey: "session token")
            self.dismiss(animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Please Enter Correct Credentials", message: "Incorrect Username Or Password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert, animated: true) {
                    self.username.text = ""
                    self.password.text = ""
                    
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgimage)
        view.addSubview(label)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(vcbutton)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgimage.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 600)
        label.frame = CGRect(x: 20, y: 180, width: view.width - 40, height: 40)
        username.frame = CGRect(x: 20, y: label.bottom + 20, width: view.width - 40, height: 40)
        password.frame = CGRect(x: 20, y: username.bottom + 20, width: view.width - 40, height: 40)
        vcbutton.frame = CGRect(x: 20, y: password.bottom + 20, width: view.width - 40, height: 40)
        
        
    }
    
    
}
