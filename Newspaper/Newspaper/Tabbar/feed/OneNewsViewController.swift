//
//  OneNewsViewController.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 13.05.22.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {
    
    var article: Article!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var safariBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = article.title
        labelDescription.text = article.description
        
        //Чтобы уменьшить задержку сделаем в отдельном потоке
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
    
    @IBAction func pushOpenAction(_ sender: UIButton) {
        if let url = URL(string: article.url) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
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
