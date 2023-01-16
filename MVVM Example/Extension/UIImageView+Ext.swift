//
//  UIImageView+Ext.swift
//  MVVM Example
//
//  Created by Admin on 16/01/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else { return}
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

