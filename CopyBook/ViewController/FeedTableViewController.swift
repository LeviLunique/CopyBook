//
//  FeedTableViewController.swift
//  CopyBook
//
//  Created by user204006 on 9/26/21.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var posts = [Post](){
        didSet{
            tableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedTableViewCell.register(in: tableView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = URL(string: "\(kBaseURL)/posts"){
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: OperationQueue.main)
            
            session.dataTask(with: url).resume()
        }
        
    }
    
    override func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.kReuseIdentifier, for: indexPath) as! FeedTableViewCell
        
        cell.setup(with: nil)
        
        let post = posts[indexPath.row]
        
        cell.postText?.text = post.body
        
        return cell
    }
}


extension FeedTableViewController: URLSessionDataDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            if let posts = try? JSONDecoder().decode([Post].self, from: data){
                self.posts = posts
            }
            
        }
    }
}
