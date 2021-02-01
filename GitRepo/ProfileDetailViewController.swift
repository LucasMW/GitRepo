//
//  ProfileDetailViewController.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array : [RepoResponse]!
    
    func loadPicture(url : String){
        API().get(str: url) { (data, response, error) in
            let image = UIImage(data: data ?? Data())
            self.picture.image = image
            self.picture.makeRounded()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("profile detail")
        print(array.count)
        self.profileNameLabel.text = array.first?.owner?.login ?? "???"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "repoCell")
        tableView.delegate = self
        tableView.dataSource = self
        let avatarURL = array.first?.owner?.avatar_url
        loadPicture(url: avatarURL ?? "")
        
        
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
