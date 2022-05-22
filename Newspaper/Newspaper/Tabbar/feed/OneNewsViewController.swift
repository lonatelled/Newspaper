//
//  OneNewsViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 13.05.22.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {
    
    // MARK: — Outlets
    
    var index: Int = 0
    var article: Article!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var safariBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = article.title
        labelDescription.text = article.description
        
        // для уменьшения задержки
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage) {
                if let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        if URL(string: self.article.url) == nil {
            safariBtn.isHidden = true
        }
    }
    
    // MARK: — Actions
    
    @IBAction func pushOpenAction(_ sender: UIButton) {
        if let url = URL(string: article.url) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
}
