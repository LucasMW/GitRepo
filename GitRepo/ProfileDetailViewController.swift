//
//  ProfileDetailViewController.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import UIKit

class RepoCell : UITableViewCell {
    
}

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array : [RepoResponse]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile detail")
        print(array.count)
        self.profileNameLabel.text = array.first?.owner?.login ?? "???"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "repoCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}
extension ProfileDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "repoCell")
        cell.detailTextLabel?.text = array[indexPath.row].language ?? "???"
        cell.textLabel?.text = array[indexPath.row].name ?? "???"
        return cell
    }
    
    
}
