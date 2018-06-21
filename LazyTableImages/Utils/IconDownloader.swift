//
//  IconDownloader.swift
//  LazyTableImages
//
//  Created by seoju on 2018. 6. 21..
//  Copyright © 2018년 seoju. All rights reserved.
//

import UIKit

let kAppIconSize: CGFloat = 48.0

class IconDownloader {

    var sessionTask: URLSessionDataTask?
    var completionHandler: (() -> Void)?
    
    let appRecord: AppRecord = AppRecord()
    
    func startDownload() {
        
        guard let imageURLString: String = appRecord.imageURLString,
            let url: URL = URL(string: imageURLString) else {
                return
        }
        
        let request: URLRequest = URLRequest(url: url)
        
        self.sessionTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data: Data = data else { return }
            
            DispatchQueue.main.async { [unowned self] in
                guard let image: UIImage = UIImage(data: data) else { return }
             
                if image.size.width != kAppIconSize || image.size.height != kAppIconSize {
                    let itemSize: CGSize = CGSize(width: kAppIconSize, height: kAppIconSize)
                    UIGraphicsBeginImageContext(itemSize)
                    let imageRect: CGRect = CGRect(x: 0.0, y: 0.0, width: itemSize.width, height: itemSize.height)
                    image.draw(in: imageRect)
                    self.appRecord.appIcon = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                } else {
                    self.appRecord.appIcon = image
                }
                
                if self.completionHandler != nil {
                    self.completionHandler!()
                }
            }
        }
        
        self.sessionTask?.resume()
    }
    
    func cancelDownload() {
        self.sessionTask?.cancel()
        self.sessionTask = nil
    }
}
