//
//  ImageFetchable.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 02/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageFetchable {
    func fetch(imageURLString: String, onImage: UIImageView, callback: @escaping () -> Void)
}

final class KFImageFetchable: ImageFetchable {
    func fetch(imageURLString: String, onImage: UIImageView, callback: @escaping () -> Void) {
        let customIndicator = CustomLoadingIndicator(image: onImage)
        if let imageURL = URL(string: imageURLString) {
            let imageResource = ImageResource(downloadURL: imageURL)
            onImage.kf.indicatorType = .custom(indicator: customIndicator)
            onImage.kf.setImage(with: imageResource, placeholder: nil, options: nil, progressBlock: nil) { image, _, _, _ in
                if let image = image {
                    onImage.image = image
                } else {
                    onImage.image = UIImage(icon: .error)
                }
                callback()
            }
        } else {
            onImage.image = UIImage(icon: .error)
            callback()
            return
        }
    }
}

struct CustomLoadingIndicator: Indicator {
    let view: UIView = UIView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    func startAnimatingView() {
        view.isHidden = false
        activityIndicator.startAnimating()
    }
    func stopAnimatingView() {
        view.isHidden = true
        activityIndicator.stopAnimating()
    }
    init(image: UIImageView) {
        activityIndicator.center = image.center
        view.addSubview(activityIndicator)
    }
}
