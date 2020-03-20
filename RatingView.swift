//
//  RatingView.swift
//  RatingView
//
//  Created by jungwook on 03/20/2020.
//  Copyright (c) 2020 jungwook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RatingView: UIStackView {
    var imageViewList = [UIImageView]()
    
    @IBInspectable
    var rating : Double = 0.0
   
    @IBInspectable
    var maxRating: Double = 5.0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var contentSpacing: CGFloat = 5 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var fillImage: UIImage = UIImage(){
        didSet {
           updateView()
        }
    }
    @IBInspectable
    var emptyImage: UIImage = UIImage(){
        didSet {
            updateView()
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
    }
    
    func updateView() {
        self.alignment = .fill
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = spacing
        
        imageViewList.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        for index in 1...Int(maxRating) {
            let imageView: UIImageView = UIImageView()
            imageView.image = emptyImage
            if index <= Int(rating){
               imageView.image = fillImage
            }
           
            imageView.tag = index
            imageView.contentMode = .scaleAspectFit
            imageViewList.append(imageView)
        }
        for image in imageViewList {
            self.addArrangedSubview(image)
        }
    }
    
    func updateViewAppearance(_ xPoint: Int) {
        for imageView in imageViewList {
            let imageViewX = Int(imageView.frame.origin.x)
            let width = Int(imageView.frame.width)
            var sumRating : Double = 0.0
            if xPoint > (imageViewX + width) {
                imageView.image = fillImage
                setNeedsDisplay()
                sumRating = 1
            }
            else {
                imageView.image = emptyImage
                setNeedsDisplay()
                sumRating = -1
            }
            if maxRating >= (rating + sumRating) && (rating + sumRating) >= 0.0 {
                rating += sumRating
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
   
}
