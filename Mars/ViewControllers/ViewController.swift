//
//  ViewController.swift
//  Mars
//
//  Created by Dinar Khakimov on 22/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker:  UIDatePicker!
    @IBOutlet weak var yearTextField:   UITextField!
    @IBOutlet weak var monthTextField:   UITextField!
    @IBOutlet weak var dayTextField:    UITextField!
    
    @IBOutlet weak var name:        UILabel!
    @IBOutlet weak var marsImage:   UIImageView!
    
    var marsRoverPhoto: MarsRoverPhotos!
    private var spinnerView = UIActivityIndicatorView()
    var date: String?
    
    @IBAction func buttonPressed(_ sender: Any) {
        showSpinner(in: view)
        
        fetchData(with: setDate(date: date ?? ""))
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.marsRoverPhoto.photos[0].imgSrc) else { return }
            DispatchQueue.main.async {
                self.marsImage.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            }
        }
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateValue = dateFormater.string(from: sender.date)
        date = dateValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        fetchData(with: Link.marsRoverPhotApi.rawValue)
        
        yearTextField.placeholder = "Year"
        monthTextField.placeholder = "Month"
        dayTextField.placeholder = "Day"
    }
    
    func fetchData(with url: String) {
        NetworkManager.shared.fetchData(from: url) { marsRoverPhoto in
            self.marsRoverPhoto = marsRoverPhoto
            self.name.text = marsRoverPhoto.photos[0].camera.fullName
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .black
        spinnerView.startAnimating()
        spinnerView.center = marsImage.center
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
    }
    
    private func setDate(date: String) -> String {
        let stringUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(date)&api_key=5ybPuL4y9ghJbYQrSWGjH0KCvcI1JMKOpH0e5Vtu"
        return stringUrl
    }
}


