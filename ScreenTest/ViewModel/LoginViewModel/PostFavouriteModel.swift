//
//  PostFavouriteModel.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import UIKit
import Alamofire
import CoreData

class PostFavouriteViewModel{
    var arrPosts = [PostFavourite]()
    weak var vc: PostFavouriteViewController?
   
    func getAllPostaWithAlamofire(){
        AF.request("https://jsonplaceholder.typicode.com/posts").response { response in
            if let data = response.data {
                do {
                    let responseData = try JSONDecoder().decode([PostFavourite].self,from: data)
                    self.arrPosts.append(contentsOf: responseData)
                    DispatchQueue.main.async {
                        self.vc?.postTableView.reloadData()
                    }
                    
                } catch let err {
                    print(err.localizedDescription)
                }
            }
            
        }
    }
    
    func getAllPosts(){
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts")!){
            (data,response,error) in
            if error == nil{
                if let data = data{
                    do {
                        let responseData = try JSONDecoder().decode([PostFavourite].self,from: data)
                        self.arrPosts.append(contentsOf: responseData)
                        
                        DispatchQueue.main.async {
                            self.vc?.postTableView.reloadData()
                        }
                        
                    } catch let err {
                        print(err.localizedDescription)
                    }
                }
                
            }else{
                print(error?.localizedDescription ?? "")
            }
        }.resume()
        
    }
    
}


    
    
