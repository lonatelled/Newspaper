//
//  FeedViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var posts: [Post] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
//        APIManager.shared.getPost(id: "post1", imageID: "1") {res1 in
//            self.posts.append(res1!)
//            APIManager.shared.getPost(id: "post2", imageID: "2") {res2 in
//                self.posts.append(res2!)
//                APIManager.shared.getPost(id: "post3", imageID: "3") {res3 in
//                    self.posts.append(res3!)
//                    APIManager.shared.getPost(id: "post4", imageID: "4") {res4 in
//                        self.posts.append(res4!)
//                        APIManager.shared.getPost(id: "post5", imageID: "5") {res5 in
//                            self.posts.append(res5!)
//                            DispatchQueue.main.async {
//                                self.table.reloadData()
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.publishedAt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOneNews", sender: self )
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneNews" {
            if let indexPath = table.indexPathForSelectedRow {
                (segue.destination as? OneNewsViewController)?.article = articles[indexPath.row]
                table.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

