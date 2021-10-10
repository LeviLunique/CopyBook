//
//  ContactsTableViewController.swift
//  CopyBook
//
//  Created by user204006 on 10/10/21.
//

import UIKit

class UserListTableViewController: UITableViewController {

    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var users = [User](){
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = URL(string: "\(kBaseURL)/users"){
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: OperationQueue.main)
            session.dataTask(with: url).resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "userAlbumsSegue"{
                        
            if let cell = sender as? UITableViewCell,
               let index = tableView.indexPath(for: cell){
                
                let user = users[index.row]
                
                if let destination = segue.destination as? UserAlbumsTableViewController {
                    destination.user = user
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultUserCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
}
extension UserListTableViewController: URLSessionDataDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            
            if let users = try? JSONDecoder().decode([User].self, from: data){
                self.users = users
            }
        }
    }
}
