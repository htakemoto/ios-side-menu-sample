//
//  RoundButton.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/13/19.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    
    // MARK: Properties
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorder(_borderWidth: borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1) {
        didSet {
            refreshBorderColor(_colorBorder: borderColor)
        }
    }
    
    @IBInspectable var customBackgroundColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
        didSet {
            refreshBackgroundColor(color: customBackgroundColor)
        }
    }
    
    // MARK: Initialization
    
    // for programmatically created buttons
    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshAll()
    }
    
    // for Storyboard/.xib created buttons
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        refreshAll()
    }
    
    // for rendering @IBDesignable controls within Storyboard
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        refreshAll()
    }
    
    // MARK: Private Methods
    
    private func refreshAll() {
        refreshCorners(value: cornerRadius)
        refreshBorder(_borderWidth: borderWidth)
        refreshBorderColor(_colorBorder: borderColor)
        refreshBackgroundColor(color: customBackgroundColor)
    }
    
    private func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    private func refreshBorder(_borderWidth: CGFloat) {
        layer.borderWidth = _borderWidth
    }
    
    private func refreshBorderColor(_colorBorder: UIColor) {
        layer.borderColor = _colorBorder.cgColor
    }
    
    private func refreshBackgroundColor(color: UIColor) {
        let image = createImage(color: color)
        setBackgroundImage(image, for: UIControl.State.normal)
        clipsToBounds = true
    }
    
    private func createImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }

}
