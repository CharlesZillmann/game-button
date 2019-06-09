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
