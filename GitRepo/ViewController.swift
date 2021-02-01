//
//  ViewController.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var repoName : String = ""
    var array : [RepoResponse] = []
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func showAlert(message : String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func inputDidEndEditing(_ sender: Any) {
        self.repoName = inputField.text ?? ""
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        let api = API()
        api.getRepo(userName: repoName) { array, error  in
            if error != nil {
                self.showAlert(message: error!.localizedDescription)
            }
            self.array = array ?? []
            print(array)
            self.performSegue(withIdentifier: "Detail", sender: nil)
        }
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

