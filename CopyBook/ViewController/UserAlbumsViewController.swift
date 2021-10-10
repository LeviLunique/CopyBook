//
//  UserAlbumsViewController.swift
//  CopyBook
//
//  Created by user204006 on 10/10/21.
//

import UIKit

class UserAlbumsTableViewController: UITableViewController {
    
        
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    var user: User?

    private var albums = [Album](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = user {
            navigationItem.title = user.name
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = URL(string: "\(kBaseURL)/users/\(String(describing: user?.id))/albums"){
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: OperationQueue.main)
            session.dataTask(with: url).resume()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultUserAlbumCell", for: indexPath)
        
        let album = albums[indexPath.row]
        
        cell.textLabel?.text = album.title
        
        
        return cell
    }
}
extension UserAlbumsTableViewController: URLSessionDataDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            
            if let albums = try? JSONDecoder().decode([Album].self, from: data){
                self.albums = albums
            }
        }
    }
}
