//
//  UIViewExtension.swift
//  sampleApp
//
//  Created by SAIL on 15/09/23.
//

import Foundation
import UIKit

extension UIView {

@IBInspectable
var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
}

   @IBInspectable
   var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
       set {
            layer.borderWidth = newValue
       }
     }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
   var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.5
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }
}


extension UIViewController {
  
  func loadImage(url: String, imageView: UIImageView?) {
      
      let baseURL = ServiceAPI.baseURL
      
   
      guard let imageUrl = URL(string: baseURL + url) else {
          return
      }
      
    
      let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
        
          guard error == nil, let imageData = data else {
              print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
              return
          }
          
         
          DispatchQueue.main.async {
              if let image = UIImage(data: imageData) {
                  // Set the loaded image to the UIImageView
                  imageView?.image = image
              }
          }
      }
      task.resume()
  }
  
  
}
      
     
      class LoadingIndicator {

          static let shared = LoadingIndicator()

          private let activityIndicator: UIActivityIndicatorView = {
              let indicator = UIActivityIndicatorView(style: .large)
              if let appColor = UIColor(named: "App Color") {
                  indicator.color = appColor
              } else {
                  indicator.color = .green 
              }

              indicator.hidesWhenStopped = true
              return indicator
          }()

          private init() {}

          func showLoading(on view: UIView) {
              DispatchQueue.main.async {
                  self.activityIndicator.center = view.center
                  view.addSubview(self.activityIndicator)
                  self.activityIndicator.startAnimating()
              }
          }

          func hideLoading() {
              DispatchQueue.main.async {
                  self.activityIndicator.stopAnimating()
                  self.activityIndicator.removeFromSuperview()
              }
             
          }
//              let mainQueue = DispatchQueue.main
//
//              // Define a delay in seconds (e.g., 2 seconds)
//              let delayInSeconds: Double = 0.3
//
//              // Specify the deadline for the delay
//              let deadline = DispatchTime.now() + delayInSeconds
//
//              // Perform a task with a delay
//              mainQueue.asyncAfter(deadline: deadline) {
//                  // Code to be executed after the delay
//                  self.activityIndicator.stopAnimating()
//                  self.activityIndicator.removeFromSuperview()
//              }
//
//
//
//
//
//          }
      }
    
        
  
  

