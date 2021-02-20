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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        
        viewModelPost.vc = self
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        self.postTableView.estimatedRowHeight = 180
        self.postTableView.rowHeight = UITableView.automaticDimension
        viewModelPost.getAllPostaWithAlamofire()

    }

    private func getpostFavouriteList(segmentedControlIndex: Int)
    {
       
    }

    // MARK: - Segment control value change event
    @IBAction func segPostFavouriteDidChangeValue(_ sender: UISegmentedControl)
    {
        switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog("Post selected. Index: %d", sender.selectedSegmentIndex)
            break;
        case 1:
            NSLog("Favourite selected. Index: %d", sender.selectedSegmentIndex)
            break;
        default:
            break;
        }
    }


}

extension PostFavouriteViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelPost.arrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        
        let modelData = viewModelPost.arrPosts[indexPath.row]
        cell?.modelUser = modelData        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
