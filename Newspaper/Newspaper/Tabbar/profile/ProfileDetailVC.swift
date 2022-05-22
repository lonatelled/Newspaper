//
//  ProfileDetailVC.swift
//  Newspaper
//
//  Created by Дарья Каркоцкая on 9.05.22.
//

import UIKit

class ProfileDetailVC: UIViewController {
    
    // MARK: — Outlets
    
    var name: String?
    
    let cells = [""]

    @IBOutlet weak var avatarImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnImage(_ :)))
        avatarImage.addGestureRecognizer(tapGesture)
        avatarImage.isUserInteractionEnabled = true
        avatarImage.layer.borderWidth = 3.0
    }
    
    
    @objc func tapOnImage(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        
        let actionPhoto = UIAlertAction(title: "С фотогалереи", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "C камеры", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionPhoto)
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapActionUserPhoto(_ sender: UITapGestureRecognizer) {
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

extension ProfileDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellForRow(at: indexPath)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    
    
}
