//
//  FeedViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 7.05.22.
//

import UIKit

final class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    // MARK: — Outlets
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControll()
        loadNews {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    // MARK: — Functions
    
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
    
    private func configureRefreshControll() {
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(handleRefreshControll), for: .valueChanged)
    }
    
    @objc func handleRefreshControll() {
        DispatchQueue.main.async {
            self.table.refreshControl?.endRefreshing()
        }
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

