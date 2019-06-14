/*************************************************************************
 MIT License
 
 Copyright (c) 2019  UIImageViewGlowExtension.swift Charles Zillmann charles.zillmann@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

private var GAMEGLOWVIEW_KEY        = "MYGLOWVIEW"
private var GAMEGLOWEDGEVIEW_KEY    = "MYGLOWEDGEVIEW"

//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
//***************        extension UIImageView
//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
extension UIImageView {
    
    //***************************************************************
    //***************        func imagerectInView() -> CGRect
    //***************************************************************
    func imagerectInView() -> CGRect {
        let imageViewSize   = frame.size
        let imgSize         = image?.size
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += frame.origin.x
        imageRect.origin.y += frame.origin.y
        
        return imageRect
    }  //func imagerectInView() -> CGRect
    
    //***************************************************************
    //***************        var glowView: UIView?
    //***************************************************************
    var glowView: UIView? {
        get {
            return objc_getAssociatedObject(self, &GAMEGLOWVIEW_KEY) as? UIView
        }  // get
        
        set(newGlowView) {
            if newGlowView != nil {
                objc_setAssociatedObject(self, &GAMEGLOWVIEW_KEY, newGlowView!, .OBJC_ASSOCIATION_RETAIN)
            } else {
                objc_setAssociatedObject(self, &GAMEGLOWVIEW_KEY, nil, .OBJC_ASSOCIATION_RETAIN)
            }  // if newGlowView != nil
        }  // set
        
    }  // var glowView: UIView?
    
    //***************************************************************
    //***************        var glowEdgeView: UIView?
    //***************************************************************
    var glowEdgeView: UIView? {
        get {
            return objc_getAssociatedObject(self, &GAMEGLOWEDGEVIEW_KEY) as? UIView
        }  // get
        
        set(newGlowView) {
            if newGlowView != nil {
                objc_setAssociatedObject(self, &GAMEGLOWEDGEVIEW_KEY, newGlowView!, .OBJC_ASSOCIATION_RETAIN)
            } else {
                objc_setAssociatedObject(self, &GAMEGLOWEDGEVIEW_KEY, nil, .OBJC_ASSOCIATION_RETAIN)
            }  // if newGlowView != nil
        }  // set
        
    }  // var glowView: UIView?
    
    //***************************************************************
    //***************        func startGlowingWithColor(color:UIColor, intensity: CGFloat)
    //***************************************************************
    func startGlowingWithColor( color       : UIColor,
                                intensity   : CGFloat ) {
        self.startGlowingWithColor( color: color, fromIntensity: 0.1, toIntensity: intensity, repeat: true)
    }  // func startGlowingWithColor(color:UIColor, intensity:CGFloat)
    
    //***************************************************************
    //***************        func startEdgeGlowingWithColor
    //***************************************************************
    func startEdgeGlowingWithColor( color       : UIColor,
                                    addedW      : CGFloat,
                                    addedH      : CGFloat,
                                    intensity   : CGFloat ) {
        
        self.startEdgeGlowingWithColor( color           : color,
                                        fromIntensity   : 0.1,
                                        toIntensity     : intensity,
                                        addedW          : addedW,
                                        addedH          : addedH,
                                        repeat          : true )
        
    }  // func startEdgeGlowingWithColor
    
    //***************************************************************
    //***************        func startGlowingWithColor(color:UIColor, fromIntensity:CGFloat, toIntensity:CGFloat, repeat shouldRepeat:Bool)
    //***************************************************************
    func startGlowingWithColor( color               : UIColor,
                                fromIntensity       : CGFloat,
                                toIntensity         : CGFloat,
                                repeat shouldRepeat : Bool ) {
        
        if self.glowView != nil {
            return
        }  // if self.glowView != nil
        
        var image : UIImage? = nil
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
            
            if let myCGContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: myCGContext)
                
                let path    = UIBezierPath( rect: CGRect( x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height ) )
                color.setFill()
                path.fill( with: .sourceAtop, alpha:1.0 )
                
                image       = UIGraphicsGetImageFromCurrentImageContext()!
            }  // if let myCGContext = UIGraphicsGetCurrentContext()
            
        }  // UIGraphicsBeginImageContextWithOptions
        
        UIGraphicsEndImageContext()
        
        if let myImage = image {
            let myGlowView                  = UIImageView(image: myImage)
            myGlowView.center               = self.center
            self.superview!.insertSubview(myGlowView, aboveSubview:self)
            
            myGlowView.alpha = 0
            myGlowView.layer.shadowColor    = color.cgColor
            myGlowView.layer.shadowOffset   = CGSize.zero
            myGlowView.layer.shadowRadius   = 10
            myGlowView.layer.shadowOpacity  = 1.0
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue             = fromIntensity
            animation.toValue               = toIntensity
            animation.repeatCount           = shouldRepeat ? .infinity : 0 // HUGE_VAL = .infinity / Thanks
            animation.duration              = 1.0
            animation.autoreverses          = true
            animation.timingFunction        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            myGlowView.layer.add(animation, forKey: "pulse")
            
            self.glowView = myGlowView
        }  // if let myImage = image
    }  // func startGlowingWithColor
    
    //***************************************************************
    //***************        func startEdgeGlowingWithColor
    //***************************************************************
    func startEdgeGlowingWithColor( color               : UIColor,
                                    fromIntensity       : CGFloat,
                                    toIntensity         : CGFloat,
                                    addedW              : CGFloat, // = 14.0,
                                    addedH              : CGFloat, //14.0
                                    repeat shouldRepeat : Bool ) {
        
        if self.glowEdgeView != nil {
            return
        }  // if self.glowEdgeView != nil
        
        var image : UIImage? = nil
        
        UIGraphicsBeginImageContextWithOptions( self.bounds.size, false, UIScreen.main.scale); do {
            
            if let myCGContext = UIGraphicsGetCurrentContext() {
                self.layer.render( in: myCGContext )
                
                let path    = UIBezierPath( rect: CGRect( x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height ) )
                color.setFill()
                path.fill( with: .sourceAtop, alpha:1.0 )
                
                image       = UIGraphicsGetImageFromCurrentImageContext()!
            }  // if let myCGContext = UIGraphicsGetCurrentContext()
            
        }  // UIGraphicsBeginImageContextWithOptions
        
        UIGraphicsEndImageContext()
        
        if let myImage = image {
            image                               = resizeImage( image: myImage, addedW: addedW, addedH: addedH )
            
            let myGlowEdgeView                  = UIImageView( image: image )
            myGlowEdgeView.center               = self.center
            self.superview!.insertSubview( myGlowEdgeView, belowSubview:self )
            
            myGlowEdgeView.alpha                = 0
            myGlowEdgeView.layer.shadowColor    = color.cgColor
            myGlowEdgeView.layer.shadowOffset   = CGSize.zero
            myGlowEdgeView.layer.shadowRadius   = 10
            myGlowEdgeView.layer.shadowOpacity  = 1.0
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue                 = fromIntensity
            animation.toValue                   = toIntensity
            animation.repeatCount               = shouldRepeat ? .infinity : 0 // HUGE_VAL = .infinity / Thanks
            animation.duration                  = 1.0
            animation.autoreverses              = true
            animation.timingFunction            = CAMediaTimingFunction( name: CAMediaTimingFunctionName.easeInEaseOut )
            
            myGlowEdgeView.layer.add( animation, forKey: "pulseEdge" )
            
            self.glowEdgeView                   = myGlowEdgeView
        }  // if let myImage = image
        
    }  // func startEdgeGlowingWithColor
    
    //***************************************************************
    //***************        func glowOnceAtLocation
    //***************************************************************
    func glowOnceAtLocation(point: CGPoint, inView view:UIView) {
        self.startGlowingWithColor( color: UIColor.white, fromIntensity: 0, toIntensity: 0.6, repeat: false )
        
        self.glowView!.center = point
        view.addSubview(self.glowView!)
        
        let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.stopGlowing()
        }  // DispatchQueue
        
    }  // func glowOnceAtLocation
    
    //***************************************************************
    //***************        func glowEdgeOnceAtLocation
    //***************************************************************
    func glowEdgeOnceAtLocation(point: CGPoint, addedW: CGFloat, addedH: CGFloat, inView view:UIView) {
        self.startEdgeGlowingWithColor(color            : UIColor.white,
                                       fromIntensity    : 0,
                                       toIntensity      : 0.6,
                                       addedW           : addedW,
                                       addedH           : addedH,
                                       repeat           : false)
        
        self.glowEdgeView!.center = point
        view.addSubview(self.glowEdgeView!)
        
        let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.stopEdgeGlowing()
        }  // DispatchQueue
        
    }  // func glowOnceAtLocation
    
    //***************************************************************
    //***************        func glowOnce
    //***************************************************************
    func glowOnce() {
        self.startGlowing()
        
        let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.stopGlowing()
        }  // DispatchQueue
        
    }  // func glowOnce
    
    //***************************************************************
    //***************        func glowOnce
    //***************************************************************
    func glowEdgeOnce() {
        self.startEdgeGlowing()
        
        let delay: Double = 2 * Double(Int64(NSEC_PER_SEC))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.stopEdgeGlowing()
        }  // DispatchQueue
        
    }  // func glowOnce
    
    //***************************************************************
    //***************        func startGlowing
    //***************************************************************
    // Create a pulsing, glowing view based on this one.
    func startGlowing() {
        self.startGlowingWithColor(color: UIColor.white, intensity:0.6);
    }  // func startGlowing
    
    //***************************************************************
    //***************        func startEdgeGlowing
    //***************************************************************
    // Create a pulsing, glowing view based on this one.
    func startEdgeGlowing() {
        self.startEdgeGlowingWithColor(color: UIColor.white, addedW : 14.0, addedH : 14.0, intensity:0.9);
    }  // func startEdgeGlowing
    
    //***************************************************************
    //***************        func stopGlowing
    //***************************************************************
    // Stop glowing by removing the glowing view from the superview
    // and removing the association between it and this object.
    func stopGlowing() {
        if self.glowView != nil {
            self.glowView!.removeFromSuperview()
            self.glowView = nil
        }  // if self.glowView != nil
    }  // func stopGlowing
    
    //***************************************************************
    //***************        func stopEdgeGlowing
    //***************************************************************
    func stopEdgeGlowing() {
        if self.glowEdgeView != nil {
            self.glowEdgeView!.removeFromSuperview()
            self.glowEdgeView = nil
        }  // if glowEdgeView != nil
    }  // func stopEdgeGlowing
    
    //***************************************************************
    //***************        func resizeImage
    //***************************************************************
    func resizeImage(image: UIImage, addedW: CGFloat, addedH: CGFloat ) -> UIImage {
        
        //let scale = newWidth / image.size.width
        let newWidth        = image.size.width + addedW
        let newHeight       = image.size.height + addedH
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        guard let newImage  = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return image
        }  // guard let newImage  = UIGraphicsGetImageFromCurrentImageContext() else
        
        UIGraphicsEndImageContext()
        return newImage
    }  // func resizeImage
    
    func shake( duration: CFTimeInterval, completion: (() -> Void)? = nil ) {
        let shakeValues : [Float] = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: .linear)
        translation.values = shakeValues
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = shakeValues.map { ( .pi *  $0 ) / 180.0 }
        
        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = 1.0
        layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    private enum Axis: StringLiteralType {
        case x = "x"
        case y = "y"
    }
    
    private func shake(on axis: Axis, completion: (() -> Void)? = nil ) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.\(axis.rawValue)")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10, 10, -10, 10, -10, 10, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
    func shakeOnXAxis(completion: (() -> Void)? = nil) {
        self.shake(on: .x)
    }
    func shakeOnYAxis(completion: (() -> Void)? = nil) {
        self.shake(on: .y)
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 0.4 , completion: (() -> Void)? = nil ) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat( .pi * 3.0 )
        rotateAnimation.duration = duration
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.3
        }, completion: completion)
    }
    
}  // extension UIImageView

//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//******************************************  END UIImageViewGlowExtension.swift
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************

struct ExplosionPiece {
    let position: CGPoint
    let image: UIImage
}

struct GlassPiece {
    let position: CGPoint
    let corners: [CGPoint]
    let image: UIImage
}

extension UIImageView  {
    
    /// Animates the view and hides it afterwards. Does nothing if view has no superview.
    ///
    /// - Parameters:
    /// - Parameter size: Describes the number of columns and rows on which the view is broken (default: 20x40)
    /// - Parameter removeAfterCompletion: Removes view from superview after animation completes
    /// - Parameter completion: Animation completion block
    func explode(size: GridSize = GridSize(columns: 20, rows: 40), removeAfterCompletion: Bool = false, completion: (() -> Void)? = nil) {
        guard let screenshot = self.screenshot, !isHidden else {
            return
        }
        
        let pieces = calculatePieces(for: screenshot, size: size)
        explodeAnimation(with: pieces, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }
    
    
    private func explodeAnimation(with pieces: [ExplosionPiece], removeAfterCompletion: Bool, completion: (() -> Void)?) {
        let animationView = UIView()
        animationView.clipsToBounds = true
        animationView.frame = self.frame
        guard let superview = self.superview else {
            return
        }
        
        self.isHidden = true
        superview.addSubview(animationView)
        
        let pieceLayers = showJointPieces(pieces, animationView: animationView)
        animateExplosion(with: pieceLayers, animationView: animationView, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }
    
    private func animateExplosion(with pieces: [CALayer], animationView: UIView, removeAfterCompletion: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationView.removeFromSuperview()
            if removeAfterCompletion {
                self.removeFromSuperview()
            }
            
            completion?()
        }
        pieces.forEach { pieceLayer in
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            animation.beginTime = CACurrentMediaTime()
            animation.duration = (0.5...1.0).random()
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isCumulative = true
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            var trans = pieceLayer.transform
            trans = CATransform3DTranslate(trans,
                                           (-self.frame.size.width...self.frame.size.width).random() * 0.3,
                                           (-self.frame.size.height...self.frame.size.height).random() * 0.3,
                                           0)
            trans = CATransform3DRotate(trans, (-1.0...1.0).random() * CGFloat.pi * 0.25, 0, 0, 1)
            let scale: CGFloat = (0.05...0.65).random()
            trans = CATransform3DScale(trans, scale, scale, 1)
            animation.toValue = NSValue(caTransform3D: trans)
            pieceLayer.add(animation, forKey: nil)
            
            let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            opacityAnimation.beginTime = CACurrentMediaTime() + (0.01...0.3).random()
            opacityAnimation.duration = (0.3...0.7).random()
            opacityAnimation.fillMode = CAMediaTimingFillMode.forwards
            opacityAnimation.isCumulative = true
            opacityAnimation.isRemovedOnCompletion = false
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            opacityAnimation.toValue = 0
            pieceLayer.add(opacityAnimation, forKey: nil)
            
        }
        CATransaction.commit()
    }
    
    private func showJointPieces(_ pieces: [ExplosionPiece], animationView: UIView) -> [CALayer] {
        var allPieceLayers = [CALayer]()
        for index in 0..<pieces.count {
            let piece = pieces[index]
            let pieceLayer = CALayer()
            pieceLayer.contents = piece.image.cgImage
            pieceLayer.frame = CGRect(x: piece.position.x, y: piece.position.y, width: piece.image.size.width, height: piece.image.size.height)
            animationView.layer.addSublayer(pieceLayer)
            allPieceLayers.append(pieceLayer)
        }
        
        return allPieceLayers
    }
    
    private func calculatePieces(for image: UIImage, size: GridSize) -> [ExplosionPiece] {
        var pieces = [ExplosionPiece]()
        let columns = size.columns
        let rows = size.rows
        
        let singlePieceSize = CGSize(width: image.size.width / CGFloat(columns), height: image.size.height / CGFloat(rows))
        
        for row in 0..<rows {
            for column in 0..<columns {
                let position = CGPoint(x: CGFloat(column) * singlePieceSize.width, y: CGFloat(row) * singlePieceSize.height)
                
                let cropRect = CGRect(x: position.x * image.scale,
                                      y: position.y * image.scale,
                                      width: singlePieceSize.width * image.scale,
                                      height: singlePieceSize.height * image.scale)
                guard
                    let cgImage = image.cgImage,
                    let pieceCgImage = cgImage.cropping(to: cropRect)
                    else {
                        continue
                }
                
                let pieceImage = UIImage.init(cgImage: pieceCgImage, scale: image.scale, orientation: image.imageOrientation)
                let piece = ExplosionPiece(position: position, image: pieceImage)
                pieces.append(piece)
            }
        }
        
        return pieces
    }
}
    
extension UIImageView  {
    /// Animates the view and hides it afterwards. Does nothing if view has no superview.
    ///
    /// - Parameter size: Describes the number of columns and rows on which the view is broken (default: 10x10)
    /// - Parameter removeAfterCompletion: Removes view from superview after animation completes
    /// - Parameter completion: Animation completion block
    public func breakGlass(size: GridSize = GridSize(columns: 10, rows: 10), removeAfterCompletion: Bool = false, completion: (() -> Void)? = nil) {
        guard let screenshot = self.screenshot, !isHidden else {
            return
        }
        
        let pieces = calculateGlassPieces(for: screenshot, size: size)
        breakAnimation(with: pieces, columns: size.columns, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }
    
    private func breakAnimation(with pieces: [[GlassPiece]], columns: Int, removeAfterCompletion: Bool, completion: (() -> Void)?) {
        let animationView = UIView()
        animationView.clipsToBounds = true
        animationView.frame = self.frame
        guard let superview = self.superview else {
            return
        }
        
        self.isHidden = true
        superview.addSubview(animationView)
        
        let pieceLayers = showJointPieces(pieces, animationView: animationView)
        animateFalling(allPieceLayers: pieceLayers, columns: CGFloat(columns), animationView: animationView, removeAfterCompletion: removeAfterCompletion, completion: completion)
    }
    
    private func showJointPieces(_ pieces: [[GlassPiece]], animationView: UIView) -> [CALayer] {
        var allPieceLayers = [CALayer]()
        for row in 0..<pieces.count {
            for column in 0..<pieces[row].count {
                let piece = pieces[row][column]
                let pieceLayer = CALayer()
                pieceLayer.contents = piece.image.cgImage
                pieceLayer.frame = CGRect(x: piece.position.x, y: piece.position.y, width: piece.image.size.width, height: piece.image.size.height)
                animationView.layer.addSublayer(pieceLayer)
                allPieceLayers.append(pieceLayer)
            }
        }
        
        return allPieceLayers
    }
    
    private func animateFalling(allPieceLayers: [CALayer], columns: CGFloat, animationView: UIView, removeAfterCompletion: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationView.removeFromSuperview()
            if removeAfterCompletion {
                self.removeFromSuperview()
            }
            
            completion?()
        }
        allPieceLayers.forEach { pieceLayer in
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            animation.beginTime = CACurrentMediaTime() + (0.3...1.0).random()
            animation.duration = (0.5...1.0).random()
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isCumulative = true
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            var trans = pieceLayer.transform
            trans = CATransform3DTranslate(trans, (-1.0...1.0).random() * self.frame.size.width / columns * 0.1, self.frame.size.height + pieceLayer.frame.size.height, 0)
            trans = CATransform3DRotate(trans, (-1.0...1.0).random() * CGFloat.pi * 0.25, 0, 0, 1)
            animation.toValue = NSValue(caTransform3D: trans)
            pieceLayer.add(animation, forKey: nil)
        }
        CATransaction.commit()
    }
    
    private func calculateCorners(for singlePieceSize: CGSize, gridSize: GridSize) -> [[CGPoint]] {
        func randomShift(for singlePieceSize: CGSize) -> CGFloat {
            return CGFloat((-1.0...1.0).random()) * singlePieceSize.width * (0.3...0.9).random()
        }
        
        var corners = Array(repeating: Array(repeating: CGPoint(), count: gridSize.columns + 1), count: gridSize.rows + 1)
        
        for row in 0...gridSize.rows {
            for column in 0...gridSize.columns {
                var point = corners[row][column]
                point.x = singlePieceSize.width * CGFloat(column)
                point.y = singlePieceSize.height * CGFloat(row)
                if column != 0 && column != gridSize.columns {
                    point.x += randomShift(for: singlePieceSize)
                }
                if row != 0 && row != gridSize.rows {
                    point.y += randomShift(for: singlePieceSize)
                }
                
                corners[row][column] = point
            }
        }
        
        return corners
    }
    
    private func calculateGlassPieces(for image: UIImage, size: GridSize) -> [[GlassPiece]] {
        var pieces = [[GlassPiece]]()
        let columns = size.columns
        let rows = size.rows
        
        let singlePieceSize = CGSize(width: image.size.width / CGFloat(columns), height: image.size.height / CGFloat(rows))
        let corners = calculateCorners(for: singlePieceSize, gridSize: size)
        
        for row in 0..<rows {
            var rowPieces = [GlassPiece]()
            for column in 0..<columns {
                let lt = corners[row][column]
                let rt = corners[row][column + 1]
                let lb = corners[row + 1][column]
                let rb = corners[row + 1][column + 1]
                
                let minX = min(lt.x, lb.x)
                let minY = min(lt.y, rt.y)
                let maxX = max(rt.x, rb.x)
                let maxY = max(lb.y, rb.y)
                
                let block = CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY).integral
                let clipPath = bezierPath(lt: lt, rt: rt, rb: rb, lb: lb, minX: minX, minY: minY, imageScale: image.scale)
                guard let pieceImage = pieceImage(from: image, sourceBlock: block, clipPath: clipPath) else {
                    continue
                }
                
                let piece = GlassPiece(position: block.origin, corners: [lt, rt, rb, lb], image: pieceImage)
                rowPieces.append(piece)
            }
            
            pieces.append(rowPieces)
        }
        
        return pieces
    }
    
    private func bezierPath(lt: CGPoint, rt: CGPoint, rb: CGPoint, lb: CGPoint, minX: CGFloat, minY: CGFloat, imageScale: CGFloat) -> UIBezierPath {
        let clipPath = UIBezierPath()
        
        clipPath.move(to: lt)
        clipPath.addLine(to: rt)
        clipPath.addLine(to: rb)
        clipPath.addLine(to: lb)
        clipPath.close()
        clipPath.apply(CGAffineTransform(translationX: -minX, y: -minY))
        clipPath.apply(CGAffineTransform(scaleX: imageScale, y: imageScale))
        
        return clipPath
    }
    
    private func pieceImage(from image: UIImage, sourceBlock: CGRect, clipPath: UIBezierPath) -> UIImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        let block = CGRect(x: sourceBlock.origin.x * image.scale,
                           y: sourceBlock.origin.y * image.scale,
                           width: sourceBlock.size.width * image.scale,
                           height: sourceBlock.size.height * image.scale)
        
        UIGraphicsBeginImageContextWithOptions(block.size, false, 1)
        guard
            let context = UIGraphicsGetCurrentContext(),
            let pieceCgImage = cgImage.cropping(to: block)
            else {
                return nil
        }
        clipPath.addClip()
        
        let tmpImage = UIImage(cgImage: pieceCgImage)
        tmpImage.draw(at: .zero)
        
        context.setBlendMode(.copy)
        context.setFillColor(UIColor.clear.cgColor)
        
        let clippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let clippedCgImage = clippedImage?.cgImage else {
            return nil
        }
        
        return UIImage(cgImage: clippedCgImage, scale: image.scale, orientation: image.imageOrientation)
    }
    
}

extension ClosedRange where Bound: FloatingPoint {
    func random() -> Bound {
        let max = UInt32.max
        return
            Bound(arc4random_uniform(max)) /
                Bound(max) *
                (upperBound - lowerBound) +
        lowerBound
    }
}

public struct GridSize {
    let columns: Int
    let rows: Int
    
    public init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
    }
}

extension UIView {
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: bounds, afterScreenUpdates: true)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }

        UIGraphicsEndImageContext()

        return image
    }
}
