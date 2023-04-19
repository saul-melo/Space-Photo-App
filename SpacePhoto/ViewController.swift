//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Saul Melo on 10/27/19.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var spacePhoto: UIImageView!
    @IBOutlet weak var photoDescriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    // Set an instance of PhotoInfoController to work with
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start with empty labels
        photoDescriptionLabel.text = ""
        copyrightLabel.text = ""
        
        // Activate network loading wheel
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Fetch the Photo of the Day and present it by updating the interface
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    // Set the view controller's photo and description using the fetched photo data
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.spacePhoto.image = image
                self.title = photoInfo.title
                self.photoDescriptionLabel.text = photoInfo.description
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = " Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
        task.resume()
    }
}

