//
//  FeedViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts: [Post] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getPost(id: "post1", imageID: "1") {res1 in
            self.posts.append(res1!)
            APIManager.shared.getPost(id: "post2", imageID: "2") {res2 in
                self.posts.append(res2!)
                APIManager.shared.getPost(id: "post3", imageID: "3") {res3 in
                    self.posts.append(res3!)
                    APIManager.shared.getPost(id: "post4", imageID: "4") {res4 in
                        self.posts.append(res4!)
                        APIManager.shared.getPost(id: "post5", imageID: "5") {res5 in
                            self.posts.append(res5!)
                            DispatchQueue.main.async {
                                self.table.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        cell.postName.text = posts[indexPath.row].name
        cell.postDate.text = posts[indexPath.row].date
        cell.postText.text = posts[indexPath.row].text
        cell.postImage.image = posts[indexPath.row].image
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

