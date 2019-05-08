//
//  ImageDownloader.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCacheLoaderCompletionHandler = ((UIImage, String) -> ())

class ImageCacheLoader {
    
    static let sharedInstanse:ImageCacheLoader = ImageCacheLoader()
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String, placeHolder:UIImage, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image, imagePath)
            }
        } else {
            DispatchQueue.main.async {
                completionHandler(placeHolder, imagePath)
            }
            let url: URL! = URL(string: imagePath)
            print(url)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img, imagePath)
                    }
                }
            })
            task.resume()
        }
    }
}
