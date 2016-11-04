//
//  UserEnterVC.swift
//  Linguist
//
//  Created by Steve on 10/31/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class UserEnterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var loadUserButton: UIButton!
    
    var isReload = false
    var isFromPresented = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isReload {
            loadUserIfSet()
        } else if isFromPresented {
            resetInterface()
        }
        isReload = false
        isFromPresented = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserIfSet()
    }
    
    // MARK: @IBAction Methods
    
    @IBAction func loadUserButtonTapped(_ sender: Any) {
        beginLoadingUser(username: userTextField.text!)
        updateInterface()
    }
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beginLoadingUser(username: userTextField.text!)
        updateInterface()
        return true
    }
    
    // MARK: (self) Methods
    
    func loadUserIfSet() {
        let username = UserDefaults.standard.string(forKey: "DuoUserName")
        if (username != nil) {
            userTextField.text = username!
            beginLoadingUser(username: username!)
            updateInterface()
        } else {
            userTextField.becomeFirstResponder()
        }
    }
    
    func updateInterface() {
        userTextField.resignFirstResponder()
        spinner.startAnimating()
        userTextField.isEnabled = false
        UIView.animate(withDuration: 2.0) {
            self.loadUserButton.alpha = 0.0
        }
    }
    
    func resetInterface() {
        userTextField.becomeFirstResponder()
        spinner.stopAnimating()
        userTextField.isEnabled = true
        UIView.animate(withDuration: 2.0) {
            self.loadUserButton.alpha = 1.0
        }
    }
    
    func beginLoadingUser(username:String) {
        let client = DuoClient.sharedInstance
        client.currentUser = username
        client.loadDuoUser(success: { (duoUser) in
            self.setDefaultUsername(username: username)
            let mainVC = VCHelper.getMainVC()
            self.present(mainVC, animated: true, completion: nil)
        }) {
            self.noticeLabel.text = "Failed to load user, try again"
            self.noticeLabel.alpha = 1.0
            self.userTextField.text = ""
        }
    }
    
    func setDefaultUsername(username:String) {
        UserDefaults.standard.set(username, forKey: "DuoUserName")
    }

}
