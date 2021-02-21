//
//  PostFavouriteViewController.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import UIKit
import CoreData

class PostFavouriteViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var segPostFavourite: UISegmentedControl!

    var viewModelPost = PostFavouriteViewModel()
    var selectedIndex = Int()
    var arrFavourite  = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        
        viewModelPost.vc = self
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        self.postTableView.estimatedRowHeight = 200
        self.postTableView.rowHeight = UITableView.automaticDimension
        viewModelPost.getAllPostaWithAlamofire()
        if let loadedCart = UserDefaults.standard.array(forKey: "Favourite") as? [[String: Any]] {
            print(loadedCart)
            self.arrFavourite.append(contentsOf: loadedCart)
        }
    }

    // MARK: - Segment control value change event
    @IBAction func segPostFavouriteDidChangeValue(_ sender: UISegmentedControl)
    {
        switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog("Post selected. Index: %d", sender.selectedSegmentIndex)
            self.selectedIndex = sender.selectedSegmentIndex
            self.postTableView.reloadData()
            break;
        case 1:
            NSLog("Favourite selected. Index: %d", sender.selectedSegmentIndex)
            self.selectedIndex = sender.selectedSegmentIndex
            if let loadedCart = UserDefaults.standard.array(forKey: "Favourite") as? [[String: Any]] {
                print(loadedCart)
                self.arrFavourite.append(contentsOf: loadedCart)
            }
            //Retrieving the value from user default
            self.postTableView.reloadData()
            break;
        default:
            break;
        }
    }


}

extension PostFavouriteViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0{
           return viewModelPost.arrPosts.count
        }else{
            return arrFavourite.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        cell?.selectionStyle = .none
        if selectedIndex == 0{
            cell?.modelUser = viewModelPost.arrPosts[indexPath.row]
        }else{
            cell?.lblTitle.text = arrFavourite[indexPath.row]["title"] as? String
            cell?.lblBody.text = arrFavourite[indexPath.row]["body"] as? String

        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex == 0{
            let alert = UIAlertController(title: "Post", message: "Do you want to add this post in favourites?? ", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                let selectedPost = self.viewModelPost.arrPosts[indexPath.row]
                
                var cart: [[String: Any]] = []
                cart.append(["title": selectedPost.title ?? "", "body": selectedPost.body ?? ""])
              //  cart.append(["title": selectedPost.title ?? "", "body": selectedPost.body ?? ""])

                let defaults = UserDefaults.standard
                defaults.setValue(cart, forKey: "Favourite")//Saved the Dictionary in user default
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                print("Yay! You brought your towel!")
            }))
            self.present(alert, animated: true)
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
