//
//  API.swift
//  GitRepo
//
//  Created by Lucas Menezes on 2/1/21.
//  Copyright © 2021 Lucas Menezes. All rights reserved.
//

import Foundation

enum APIErrors: Error {
    case networkError
    case noUserError
    
    func toMessage() -> String {
        switch self {
        case .networkError:
            return "A network error has occurred. Check your Internet connection and try again later"
        case .noUserError:
            return "User not found. Please enter another name"
        }
    }
}
class API {
    
    
    func get(str : String, handler : @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        guard let url = URL(string: str) else {
            
            handler(nil,nil, APIErrors.networkError)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                handler(data,response,error)
            }
            
        }
        
        task.resume()
    }
    func getRepo(userName : String, completion : @escaping ( ([RepoResponse]?, APIErrors?) -> ()  ) )  {
        let urlString = "https://api.github.com/users/\(userName)/repos"
        print(urlString)
        get(str: urlString) { (data, response, error) in
            if error != nil {
                completion(nil, .networkError)
                
            }
            let jsonDecoder = JSONDecoder()
            guard let responseModel = try?
                
                jsonDecoder.decode(Array<RepoResponse>.self, from: data ?? Data())
                else {
                    guard let string = String(data: data ?? Data(), encoding: .utf8) else {
                        
                        completion(nil, APIErrors.networkError)
                        return
                    }
                    if string.contains("Not Found"){
                        
                        completion(nil, APIErrors.noUserError)
                    }
        
                    return
            }
            if(responseModel.count == 0){
                completion(nil, APIErrors.networkError)
            }
            completion(responseModel, nil)
            print(responseModel.count)
        
        }
        
    }
}
