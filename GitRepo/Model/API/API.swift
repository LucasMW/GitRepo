//
//  API.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import Foundation

class API {

    let networkError = NSError(domain: "A network error has occurred. Check your Internet connection and try again later", code: 01, userInfo: nil)
    let noUserError = NSError(domain: "User not found. Please enter another name", code: 02, userInfo: nil)
    
    func get(str : String, handler : @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        guard let url = URL(string: str) else {
            handler(nil,nil, noUserError)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                handler(data,response,error)
            }
            
        }
        
        task.resume()
    }
    func getRepo(userName : String, completion : @escaping ( ([RepoResponse]?, Error?) -> ()  ) )  {
        let urlString = "https://api.github.com/users/\(userName)/repos"
        get(str: urlString) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            guard let responseModel = try? jsonDecoder.decode(Array<RepoResponse>.self, from: data ?? Data())
                else {
                    completion(nil, self.networkError)
                    return
            }
            completion(responseModel, nil)
            print(responseModel.count)
        
        }
        
    }
}
