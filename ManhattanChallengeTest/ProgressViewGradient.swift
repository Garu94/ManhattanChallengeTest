//
//  ProgressViewGradient.swift
//  Dynamic_Progress_Bar
//
//  Created by Francesca Palese on 18/12/2017.
//  Copyright © 2017 Fabrizio Maggiacomo. All rights reserved.
//

import Foundation
import UIKit


public class GradientProgressBar : UIProgressView {

    var leftPercentage: Float = 1.0
    // MARK: - Properties
    
    /// An array of CGColorRef objects defining the color of each gradient stop. Animatable.429321429321429321
    
    public var gradientColors: [CGColor] = [#colorLiteral(red: 0, green: 0.5890474916, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.5089857578, green: 0.8691968918, blue: 0, alpha: 1).cgColor] {
        didSet {
            gradientLayer.colors = gradientColors
        }
    }
    
//    public var trackGradientColors: [CGColor] = [#colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1).cgColor, #colorLiteral(red: 0.9175666571, green: 0.9176985621, blue: 0.9175377488, alpha: 1).cgColor] {
//        didSet {
//            trackGradientLayer.colors = trackGradientColors
//        }
//    }
    

    
    /** The radius to use when drawing rounded corners for the gradient layer and progress view backgrounds. Animatable.
     *   The default value of this property is 0.0.
     */
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
//    public override var trackTintColor: UIColor? {
//        didSet {
//            if trackTintColor != UIColor.clear {
//                backgroundColor = trackTintColor
//                trackTintColor = UIColor.clear
//            }
//        }
//    }
    
    public override var progressTintColor: UIColor? {
        didSet {
            if progressTintColor != UIColor.clear {
                progressTintColor = UIColor.clear
            }
        }
    }
    
    lazy private var gradientLayer: CAGradientLayer = self.initGradientLayer()
    
//    lazy private var trackGradientLayer: CAGradientLayer = self.initTrackGradientLayer()
    
    // MARK: - init methods
    
    override public init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateGradientLayer()
    }
    
    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        updateGradientLayer()
    }
    
    // MARK: - Private methods
    
    private func setup() {
//        self.layer.cornerRadius = cornerRadius
//        self.layer.addSublayer(trackGradientLayer)
//        trackTintColor = UIColor.clear
//        trackGradientLayer.colors = trackGradientColors
        
        self.layer.cornerRadius = cornerRadius
        self.layer.addSublayer(gradientLayer)
        progressTintColor = UIColor.clear
        gradientLayer.colors = gradientColors
    }
//
//    private func initTrackGradientLayer() -> CAGradientLayer {
//        let trackGradientLayer = CAGradientLayer()
//        trackGradientLayer.frame = backgroundShape(originalRect: bounds, width: CGFloat(1))
//        trackGradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
//        trackGradientLayer.position = CGPoint(x: 0, y: 0)
//        trackGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        trackGradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
//        trackGradientLayer.cornerRadius = cornerRadius
//        trackGradientLayer.masksToBounds = true
//        return trackGradientLayer
//    }
    
    private func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        return gradientLayer
    }
    
    public func updateGradientLayer() {
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(leftPercentage))
        gradientLayer.cornerRadius = cornerRadius
    }
    
    public func sizeByPercentage(originalRect: CGRect, width: CGFloat) -> CGRect {
        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
        return CGRect(origin: originalRect.origin, size: newSize)
    }
//
//    public func backgroundShape(originalRect: CGRect, width: CGFloat) -> CGRect {
//        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
//        return CGRect(origin: originalRect.origin, size: newSize)
//    }
}
