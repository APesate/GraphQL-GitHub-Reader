//
//  UIImageView+Caching.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 01/01/2022.
//

import Foundation
import Kingfisher
import class UIKit.UIImageView
import class UIKit.UIImage

extension UIImageView {
  func setImage(from url: URL, placeholder: UIImage? = nil) {
    kf.setImage(with: url, placeholder: placeholder)
  }
}
