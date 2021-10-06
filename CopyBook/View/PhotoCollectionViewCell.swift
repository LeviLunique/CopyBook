//
//  PhotoCollectionViewCell.swift
//  CopyBook
//
//  Created by user204006 on 10/3/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func setup(with url: URL){
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    photoImageView.image = UIImage(data: data)
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
