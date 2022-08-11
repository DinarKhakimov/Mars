//
//  DetailPhotoViewController.swift
//  Mars
//
//  Created by Dinar Khakimov on 5/8/22.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    
    var marsPhoto: Photo!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    private var spinerView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        showSpiner(in: view)
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.marsPhoto.imgSrc) else { return }
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(data: imageData)
                self.spinerView.stopAnimating()
            }
            
        }

        
    }
    
    private func showSpiner(in view: UIView) {
        spinerView = UIActivityIndicatorView(style: .large)
        spinerView.color = .black
        spinerView.startAnimating()
        spinerView.center = photoImage.center
        spinerView.hidesWhenStopped = true
        
        view.addSubview(spinerView)
        
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
