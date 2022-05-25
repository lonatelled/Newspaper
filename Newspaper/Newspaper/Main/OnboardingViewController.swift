//
//  OnboardingSceneOneVC.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 20.05.22.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configure
    
    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Добро пожаловать!", "Читайте только свежие новости", "Общайтесь с интересными для вас людьми"]
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10 + 120 + 10, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 60 - 130 - 15))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width - 20, height: 50))
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.numberOfLines = 0
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x+1)")
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Продолжить", for: .normal)
            
            if x == 2 {
                button.setTitle("Давай начнём!", for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapBtn(_:)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    // MARK: - Navigation
    
    @objc func didTapBtn(_ button: UIButton) {
        guard button.tag < 3 else {
            dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Tabbar") as! TabbarController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}
