//
//  ViewController.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var repoName : String = "LucasMW"
    var array : [RepoResponse] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        let api = API()
        api.getRepo(userName: repoName) { array in
            self.array = array
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

