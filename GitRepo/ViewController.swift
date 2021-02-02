//
//  ViewController.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var repoName : String = ""
    var array : [RepoResponse] = []
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        inputField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
        collectName()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        collectName()
        return true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func showAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.navigationController?.popToRootViewController(animated: true)
            self.view.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        
    }
    func showAlert(message : String) {
        showAlert(title: "Error", message: message)
    }
    func collectName() {
        self.repoName = inputField.text ?? ""
    }
    @IBAction func inputDidEndEditing(_ sender: Any) {
        collectName()
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        print("Pressed")
        let api = API()
        api.getRepo(userName: repoName) { array, error  in
            if error != nil {
                print(error)
                self.showAlert(message: error?.toMessage() ?? "???")
                return
            }
            self.array = array ?? []
            let vc = ProfileDetailViewController()
            vc.array = array
            self.view.window?.rootViewController?.present(vc, animated: true, completion: nil)
            //self.performSegue(withIdentifier: "Detail", sender: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let vc = segue.destination as? ProfileDetailViewController else {
                return
            }
            vc.array = array
            
            
        }
    }


}

