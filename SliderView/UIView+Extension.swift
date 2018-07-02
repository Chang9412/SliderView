//
//  File.swift
//  Project1
//
//  Created by zzq on 2018/5/17.
//  Copyright © 2018年 zzq. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width/2
            self.frame = frame
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.height/2
            self.frame = frame
        }
    }
   
   
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    // MARK: 圆角
    func roundCorners(corners: UIRectCorner, radius: CGFloat)  {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    func roundCorners(radius: CGFloat, _ borderWidth: CGFloat, _ borderColor: UIColor)  {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    class func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    class func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
   
  /*
    var currentViewController: UIViewController {
        get {
//            for(let next = self.superview; next; next = next.superview) {
     
//            }
           
        }
        
        
    }
   */
    
   
    
    
}

extension UIColor {
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(255))
        let g = CGFloat(arc4random_uniform(255))
        let b = CGFloat(arc4random_uniform(255))
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    class func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
extension UIButton {
    class func creatButton(frame: CGRect, normalImage: UIImage?, selectedImage: UIImage?, target: Any?, selector:Selector) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
    class func creatButton(frame: CGRect, title: String?, titleColor: UIColor?, selectedColor: UIColor?, target: Any?, selector:Selector) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
}

extension UILabel {
    class func creatLabel(frame: CGRect, title: String?, titleColor: UIColor?, font: UIFont, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = title
        label.textColor = titleColor
        label.font = font
        label.textAlignment = textAlignment
        return label
    }
}

extension UITextField {
    class func creatTextField(frame: CGRect, text: String?, textColor: UIColor?, font: UIFont, placeholder: String?, placeholderColor: UIColor?, delegate:Any?, borderStyle:UITextBorderStyle) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.text = text
        textField.textColor = textColor
        textField.font = font
        textField.borderStyle = borderStyle
        textField.setValue(placeholderColor, forKey: "placeholderColor")
        return textField
    }
}
extension UITextView {
    class func creatTextView(frame: CGRect, text: String?, textColor: UIColor?, font: UIFont, delegate:Any?) -> UITextView {
        let textView = UITextView(frame: frame)
        textView.text = text
        textView.textColor = textColor
        textView.font = font
        return textView
    }
}
