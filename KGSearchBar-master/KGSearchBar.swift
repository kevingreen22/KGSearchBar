//
//  KGSearchBar.swift
//  TestSearchBar
//
//  Created by Kevin Green on 11/17/19.
//  Copyright © 2019 com.kevinGreen. All rights reserved.
//
// A designable basic search bar with and indented look.

import Foundation
import UIKit

@IBDesignable
class KGSearchBar: UIView {
    
    //MARK: - Private Instance Variables
    private let kCONTENT_XIB_NAME = "KGSearchBar"
    private var cornerRadius: CGFloat!
    private let shapeLayer = CAShapeLayer()
    private let shadowLayer = CALayer()
    private var privateStrokeAlpha: CGFloat = 0.3
    
    
    
    // MARK: - Inspectable Variables
    @IBInspectable public var lineWidth: CGFloat = 2.0 { didSet { shapeLayer.lineWidth = self.lineWidth } }
    @IBInspectable public var strokeColor: UIColor = UIColor.lightGray { didSet { shapeLayer.strokeColor = self.strokeColor.cgColor } }
    @IBInspectable public var strokeAlpha: CGFloat = 0.3 { didSet { privateStrokeAlpha = self.strokeAlpha  } }
    @IBInspectable public var fillColor: UIColor = UIColor.clear { didSet { shapeLayer.fillColor = self.fillColor.cgColor } }
    @IBInspectable public var position: CGPoint = CGPoint(x: 0, y: 0) { didSet { shapeLayer.position = self.position } }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black { didSet { shadowLayer.shadowColor = self.shadowColor.cgColor } }
    @IBInspectable public var shadowOffset: CGSize = CGSize.zero { didSet { shadowLayer.shadowOffset = self.shadowOffset } }
    @IBInspectable public var shadowRadius: CGFloat = 2.5 { didSet { shadowLayer.shadowRadius = self.shadowRadius } }
    @IBInspectable public var shadowOpacity: Float = 0.8 { didSet { shadowLayer.shadowOpacity = self.shadowOpacity } }
    
    
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var KGsearchTextField: UITextField!
    @IBOutlet weak var KGmagnifyingGlassImageView: UIImageView!
    
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\n**** KGSearchBar ****")
        xibSetUp()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("\n**** KGSearchBar ****")
        xibSetUp()
        commonInit()
    }
    
    /// Used to resize the layers of the KGSearchBar for orientation changes.
    override func layoutSubviews() {
        commonInit()
    }
    
    
    
    // MARK: - Private Methods
    
    /// Initial XIB setup
    fileprivate func xibSetUp() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        cornerRadius = contentView.bounds.height / 2
        contentView.layer.cornerRadius = cornerRadius
    }
    
    
    /// Initializes the layers of the KGSearchBar
    fileprivate func commonInit() {
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = createBezierPath().cgPath
        
        // apply other properties related to the path
        shapeLayer.strokeColor = strokeColor.withAlphaComponent(strokeAlpha).cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.position = position
        
        // apply the shadow to the shapeLayer
        let shadowSubLayer = createShadowLayer()
        shadowSubLayer.insertSublayer(shapeLayer, at: 0)
        
        // add the new layer to our custom view
        self.layer.addSublayer(shadowSubLayer)
    }
    
    
    /// Creates the bezier path of the KGSearchBar for the indented look.
    fileprivate func createBezierPath() -> UIBezierPath {
        // create a new path
        let path = UIBezierPath()
                
        // starting point for the path (top left)
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        
        // top line
        print(path.currentPoint)
        path.addLine(to: CGPoint(x: self.bounds.maxX - cornerRadius, y: 0))

        // right arc (half circle)
        print(path.currentPoint)
        let centerPointR = CGPoint(x: path.currentPoint.x, y: self.bounds.height / 2) // center point of right side of textfield arc
        path.addArc(
            withCenter: centerPointR, // center point of circle
            radius: cornerRadius,
            startAngle: CGFloat((3 * Double.pi) / 2),
            endAngle: CGFloat(Double.pi / 2),
            clockwise: true
        )

        // bottom line
        print(path.currentPoint)
        path.addLine(to: CGPoint(x: cornerRadius, y: self.bounds.height))

        // left arc (half circle)
        print(path.currentPoint)
        let centerPointL = CGPoint(x: path.currentPoint.x, y: self.bounds.height / 2) // center point of left side of textfield arc
        path.addArc(
            withCenter: centerPointL,
            radius: cornerRadius,
            startAngle: CGFloat(Double.pi / 2),
            endAngle: CGFloat((3 * Double.pi) / 2),
            clockwise: true
        )
        
        print(path.currentPoint)
        path.close() // draws the final line to close the path
        
        return path
    }
    
    
    /// Creates the shadow layer for the indented look.
    fileprivate func createShadowLayer() -> CALayer {
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        return shadowLayer
    }
    
    
}
