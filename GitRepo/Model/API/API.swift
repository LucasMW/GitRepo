//
//  API.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import Foundation

class API {

    
    func get(str : String, handler : @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        let url = URL(string: str)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                handler(data,response,error)
            }
            
        }
        
        task.resume()
    }
    func getRepo(userName : String, completion : @escaping ( ([RepoResponse]) -> ()  ) )  {
        let urlString = "https://api.github.com/users/\(userName)/repos"
        get(str: urlString) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            guard let responseModel = try? jsonDecoder.decode(Array<RepoResponse>.self, from: data ?? Data())
                else {
                    return
            }
            completion(responseModel)
            print(responseModel.count)
        
        }
        
    }
}
