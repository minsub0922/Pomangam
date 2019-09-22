//
//  FasterImageView.swift
//  PomangamiOS
//
//  Created by 최민섭 on 15/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class FasterImageView: UIImageView {
    private var url: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadImageAsyc(url urlString : String){
        guard let url = URL(string: urlString) else { return }
        self.url = urlString
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data:Data?, res:URLResponse?, error:Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.global().async {
                let imageToCache = UIImage(data: data!)
                if self.url == urlString {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                    }
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }).resume()
    }
}
