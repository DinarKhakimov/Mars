//
//  TableViewCell.swift
//  Mars
//
//  Created by Dinar Khakimov on 4/8/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var marsImageView: UIImageView! {
        didSet {
            marsImageView.contentMode = .scaleAspectFit
            marsImageView.clipsToBounds = true
            marsImageView.layer.cornerRadius = marsImageView.frame.height / 2
            marsImageView.backgroundColor = .black
        }
        
    }
    func configure(with photo: Photo?) {
        nameLabel.text = photo?.camera.fullName 
        DispatchQueue.global().async {
            guard let stringURL = photo?.imgSrc else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.marsImageView.image = UIImage(data: imageData)
            }
        }
    }
}
