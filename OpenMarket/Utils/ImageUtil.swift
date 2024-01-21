//
//  ImageUtil.swift
//  OpenMarket
//
//  Created by Cristhian Tolosa on 2024-01-20.
//

import Foundation
import UIKit

class ImageUtil {
    
    static func downloadImage(from url: URL, uiImageView: UIImageView, width: Int, height: Int) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                let resizedImage = self.resizeImage(image, targetSize: CGSize(width: width, height: height))
                DispatchQueue.main.async {
                    uiImageView.image = resizedImage
                }
            }
        }.resume()
    }
    
    private static func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage ?? UIImage()
    }
}


