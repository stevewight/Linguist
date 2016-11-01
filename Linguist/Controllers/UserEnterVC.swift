//
//  UserEnterVC.swift
//  Linguist
//
//  Created by Steve on 10/31/16.
//  Copyright © 2016 31Labs. All rights reserved.
//

import UIKit

class UserEnterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var loadUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.becomeFirstResponder()
    }
    
    // MARK: @IBAction Methods
    
    @IBAction func loadUserButtonTapped(_ sender: Any) {
        beginLoadingUser()
    }
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beginLoadingUser()
        return true
    }
    
    // MARK: (self) Methods
    
    func updateInterface() {
        userTextField.resignFirstResponder()
        spinner.startAnimating()
        userTextField.isEnabled = false
        UIView.animate(withDuration: 2.0) {
            self.loadUserButton.alpha = 0.0
        }
    }
    
    func beginLoadingUser() {
        let client = DuoClient.sharedInstance
        client.currentUser = userTextField.text!
        client.loadDuoUser { (duoUser) in
            let mainVC = self.getMainVC()
            self.present(mainVC, animated: true, completion: nil)
        }
    }
    
    func getMainVC()-> MainVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "MainVC"
        ) as! MainVC
        return vc
    }

}
