/*************************************************************************
 MIT License
 
 Copyright (c) 2019  GameButton.swift Charles Zillmann charles.zillmann@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import AVFoundation

//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
//***************        class GameButton: UIButton
//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
class GameButton : UIButton {
    
    //GameButton Glowing effect Properties
    var GlowDuration     : CGFloat   = 3
    var GlowCornerRadius : CGFloat   = 5
    var GlowColor        : UIColor?  = nil {
        didSet {
            if let myColor = GlowColor?.cgColor {
                self.layer.shadowColor  = myColor
            }  //if let myColor = GlowColor?.cgColor
        }  //didSet
    }  // var GlowColor        : UIColor?  = nil
    var GlowIntensity    : CGFloat   = 0.4
    var GlowMaxSize      : CGFloat   = 16
    var GlowMinSize      : CGFloat   = 0
    var GlowTopInset     : CGFloat   = 5
    var GlowBottomInset  : CGFloat   = 4
    var GlowLeftInset    : CGFloat   = 3
    var GlowRightInset   : CGFloat   = 3
    
    //Center Image
    var CenterImage    : UIImage?  = nil
    var CIGlowColor    : UIColor?  = nil
    var CIIntensity    : CGFloat   = 0.4
    var CITopInset     : CGFloat   = 20
    var CIBottomInset  : CGFloat   = 20
    var CILeftInset    : CGFloat   = 20
    var CIRightInset   : CGFloat   = 20
    
    //A1 Image
    var TLImage       : UIImage?  = nil
    var TLGlowColor   : UIColor?  = nil
    var TLIntensity   : CGFloat   = 0.4
    var TL_x          : CGFloat   = 0
    var TL_y          : CGFloat   = 0
    var TL_w_pct      : CGFloat   = 20
    var TL_h_pct      : CGFloat   = 20
    
    //B2 Image
    var TRImage       : UIImage?  = nil
    var TRGlowColor   : UIColor?  = nil
    var TRIntensity   : CGFloat   = 0.4
    var TR_x          : CGFloat   = 0
    var TR_y          : CGFloat   = 0
    var TR_w_pct      : CGFloat   = 20
    var TR_h_pct      : CGFloat   = 20
    
    //Glowing effect Properties
    var GlowEnabled      : Bool      = false {
        didSet {
            if GlowEnabled {
                self.startAnimation()
            }  else {
                self.stopAnimation()
            }//if GlowEnabled
        }  //didSet
    }  //@IBInspectable var GlowEnabled
    
    var CIisHidden     : Bool      = false {
        didSet {
            StopCenterImageGlow()
            CenterImageView.isHidden = CIisHidden
        }  //didSet
    }  //@IBInspectable var CIisHidden
    
    var TLBadgeisHidden    : Bool      = false {
        didSet {
            StopTLBadgeGlow()
            TLBadgeView.isHidden = TLBadgeisHidden
        }  //didSet
    }  //@IBInspectable var AisHidden
    
    var TRBadgeisHidden    : Bool      = false {
        didSet {
            StopTRBadgeGlow()
            TRBadgeView.isHidden = TRBadgeisHidden
        }  //didSet
    }  //@IBInspectable var BisHidden
    
    // CenterImageView is the is the image centered within the button's primary image
    let CenterImageView           : UIImageView         = {
        let myView = UIImageView()
        myView.isHidden = false
        return myView
    } ()
    
    // TLBadgeView is the topleft badge on this button
    let TLBadgeView           : UIImageView         = {
        let myView = UIImageView()
        myView.isHidden = true
        return myView
    } ()
    
    // TRBadgeView is the topright badge on this button
    let TRBadgeView           : UIImageView         = {
        let myView = UIImageView()
        myView.isHidden = true
        return myView
    } ()
    
    //***************************************************************
    //***************        required init?(coder aDecoder: NSCoder)
    //***************************************************************
    required init?( coder aDecoder : NSCoder ) {
        super.init( coder : aDecoder )
    }  //required init?(coder aDecoder: NSCoder)
    
    //***************************************************************
    //***************        override func awakeFromNib()
    //***************************************************************
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentScaleFactor     = UIScreen.main.scale
        self.layer.masksToBounds    = false
        self.setupGameButtonImageViews()
        self.setupButtonImage()
        
        //Now we can add the imageviews as subviews to this button
        addSubview(CenterImageView)
        addSubview(TLBadgeView)
        addSubview(TRBadgeView)
    }  //override func awakeFromNib()
    
    //***************************************************************
    //***************        override init(frame: CGRect)
    //***************************************************************
    override init( frame : CGRect ) {
        super.init( frame : frame )
    }  //override init(frame: CGRect)
    
    //***************************************************************
    //*********   func getTargetRectangle() -> CGRect
    //***************************************************************
    func getTargetRectangle() -> CGRect {
        
        //We have to find our target rectangle hat we will use to position our A & B image views
        //The target Rectangle will be specified relative to the button's view coordinates
        if imageView != nil && imageView?.image != nil {
            
            //First Choice is to put the A Image on the PRIMARY ImageView's Graphic
            let myTIV   : UIImageView   = imageView!
            let myTI    : UIImage       = imageView!.image!
            return  AVMakeRect( aspectRatio : myTI.size,
                                insideRect  : myTIV.frame )
            
        } else if CenterImageView.image != nil {
            
            //Second Choice is to put the A Image on the CENTER ImageView's Graphic
            let myTIV   : UIImageView   = CenterImageView
            let myTI    : UIImage       = CenterImageView.image!
            return  AVMakeRect( aspectRatio : myTI.size,
                                insideRect  : myTIV.bounds )
            
        } else {
            
            //Third Choice is to put the A Image on the BUTTON in the TOPLEFT Corner
            return self.bounds
            
        } // IF
        
    }  // func getTargetRectangle() -> CGRect
    
    //***************************************************************
    //*********   func setupGameButtonImageViews()
    //***************************************************************
    func setupGameButtonImageViews( theCenterImage  : UIImage? = nil,
                                    theTLImage      : UIImage? = nil,
                                    theTRImage      : UIImage? = nil ) {
        
        self.imageView?.contentMode         = UIView.ContentMode.scaleAspectFit
        self.CenterImageView.contentMode    = UIView.ContentMode.scaleAspectFit
        self.TLBadgeView.contentMode        = UIView.ContentMode.scaleAspectFit
        self.TRBadgeView.contentMode        = UIView.ContentMode.scaleAspectFit
        
        let myBaseRect      : CGRect        = self.bounds
        
        //If we have a center image then we will add it to the center image view
        // and we will center the center image view
        // and we will adjust the center image view with insets as the user has specified
        if CenterImage != nil {
            CenterImageView.image   = CenterImage
            
            let myCILInset  : CGFloat = (  CILeftInset/100   ) * myBaseRect.width
            let myCITInset  : CGFloat = (  CITopInset/100    ) * myBaseRect.height
            let myCIRInset  : CGFloat = (  CIRightInset/100  ) * myBaseRect.width
            let myCIBInset  : CGFloat = (  CIBottomInset/100 ) * myBaseRect.height
            
            let myRect      : CGRect = CGRect( x        : myBaseRect.minX + myCILInset,
                                               y        : myBaseRect.minY + myCITInset,
                                               width    : myBaseRect.width - (myCILInset + myCIRInset),
                                               height   : myBaseRect.height - (myCITInset + myCIBInset))
            CenterImageView.frame = myRect
        }  //if CenterImage != nil
        
        setupTLBadge()
        setupTRBadge()
        
    }  //func setupGameButtonImageViews()
    
    //***************************************************************
    //***************        func setupTLBadge()
    //***************************************************************
    func setupTLBadge() {
        
        //If we have an A image then we will add it to the A image view
        // and we will move the A image view to the TOP LEFT of the target rectangle
        // and we will adjust the A image view with insets as the user has specified
        if TLImage != nil, let myImageView = self.imageView {
            
            TLBadgeView.image   = TLImage

            //We have to find our target rectangle hat we will use to position our A & B image views
            //The target Rectangle will be specified relative to the button's view coordinates
            let myTA        : CGRect    = myImageView.imagerectInView()

            ///////////////////////////////////////////////////////
            //The A ImageView Frame is specified as a percentage of the size of the Target Rectangle
            let myAWidth    : CGFloat   = myTA.width  * TL_w_pct/100
            let myAHeight   : CGFloat   = myTA.height * TL_h_pct/100
            
            //Set the initial dimensions of the A imageview Frame so that we can find the final location of the A image within its frame
            TLBadgeView.frame = CGRect( x       : myTA.minX,
                                        y       : myTA.minY,
                                        width   : myAWidth,
                                        height  : myAHeight )
            
            let myTLI : CGRect = TLBadgeView.imagerectInView()
 
            //Adjust the frame one last time so that the A Image is positioned correctly and apply A_x and A_y user specified adjustment values
            TLBadgeView.frame = CGRect( x       : myTA.minX - (myTLI.minX - myTA.minX ) + TL_x,
                                        y       : myTA.minY - (myTLI.minY - myTA.minY ) + TL_y,
                                        width   : myAWidth,
                                        height  : myAHeight )
        }  // if TLImage != nil, let myImageView = self.imageView

    }  // func setupTLBadge()
    
    //***************************************************************
    //***************        func setupTRBadge()
    //***************************************************************
    func setupTRBadge() {
        
        //If we have an B image then we will add it to the B image view
        // and we will move the B image view to the TOP RIGHT of the target rectangle
        // and we will adjust the B image view with insets as the user has specified
        if TRImage != nil, let myImageView = self.imageView  {
            
            TRBadgeView.image        = TRImage

            //We have to find our target rectangle hat we will use to position our A & B image views
            //The target Rectangle will be specified relative to the button's view coordinates
            let myTA   : CGRect     = myImageView.imagerectInView()

            ///////////////////////////////////////////////////////
            //The B ImageView Frame is specified as a percentage of the size of the Target Rectangle
            let myBWidth  : CGFloat = myTA.width   * TR_w_pct/100
            let myBHeight : CGFloat = myTA.height  * TR_w_pct/100
            
            //Set the initial dimensions of the B imageview Frame so that we can find the final location of the B image within its frame
            TRBadgeView.frame = CGRect( x       : myTA.minX,
                                        y       : myTA.minY,
                                        width   : myBWidth,
                                        height  : myBHeight )
            
            //Calculate the dimensions of the B image within the B imageview Frame
            let myTRI : CGRect = TRBadgeView.imagerectInView()
            
            TRBadgeView.frame = CGRect( x        : ( myTA.minX + myTA.width ) - ((myTRI.minX - myTA.minX) + myTRI.width) + TR_x,
                                        y        : myTA.minY - (myTRI.minY - myTA.minY ) + TR_y,
                                        width    : myBWidth,
                                        height   : myBHeight )
            
        }  // if TRImage != nil, let myImageView = self.imageView
        
    }  // func setupTRBadge()
    
    //***************************************************************
    //***************        func setupButton()
    //***************************************************************
    func setupButtonImage( theImage : UIImage? = nil ) {
        
        // Set the Buttons Primary Image if one is provided programatically
        if theImage != nil {
            self.imageView?.image = theImage
        }  // if theImage != nil
        
        self.layer.cornerRadius     = GlowCornerRadius
        
        // Get the button bounds CGRect as myBaseRect
        let myBaseRect  : CGRect    = self.bounds
        
        // If no button image exists the defalt rectangle will be the button bounds
        var myIRect     : CGRect    = myBaseRect
        
        // See if there is an image and get the images rectangle as it will be placed within the button
        if let myIV = self.imageView {
            myIRect = AVMakeRect( aspectRatio   : myIV.image?.size ?? CGSize(width: myIV.bounds.width, height: myIV.bounds.height),
                                  insideRect    : myIV.bounds )
            myIRect = CGRect(x      : myIV.frame.minX + myIRect.minX,
                             y      : myIV.frame.minY + myIRect.minY,
                             width  : myIRect.width ,
                             height : myIRect.height)
        }  // if let myImageView = self.imageView
        
        // Adjust the shadow path used for glowing according to the user specified parameters from interface builder
        let myRect : CGRect = CGRect(   x       : myIRect.minX      + GlowLeftInset,
                                        y       : myIRect.minY      + GlowTopInset,
                                        width   : myIRect.width     - (GlowLeftInset + GlowRightInset),
                                        height  : myIRect.height    - (GlowTopInset + GlowBottomInset))
        
        // Use the buttons image to specify the actual glowing rectangle
        self.layer.shadowPath       = CGPath( roundedRect   : myRect,
                                              cornerWidth   : GlowCornerRadius,
                                              cornerHeight  : GlowCornerRadius,
                                              transform     : nil)
        if let myColor = GlowColor?.cgColor {
            self.layer.shadowColor  = myColor
        }  //if let myColor = GlowColor?.cgColor
        
        self.layer.shadowOffset     = CGSize.zero
        self.layer.shadowRadius     = GlowMaxSize
        self.layer.shadowOpacity    = 0
    }  //func setupButton()

    //***************************************************************
    //***************        func startAnimation()
    //***************************************************************
    func startAnimation() {
        let layerAnimation                      = CABasicAnimation( keyPath: "shadowRadius" )
        layerAnimation.fromValue                = GlowMaxSize
        layerAnimation.toValue                  = GlowMinSize
        layerAnimation.autoreverses             = true
        layerAnimation.isAdditive               = false
        layerAnimation.duration                 = CFTimeInterval( GlowDuration/2 )
        layerAnimation.fillMode                 = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion    = false
        layerAnimation.repeatCount              = .infinity
        self.layer.add( layerAnimation, forKey : "glowingAnimation" )
        self.layer.shadowOpacity                = 1.00
    }  //func startAnimation()
    
    //***************************************************************
    //***************        func stopAnimation()
    //***************************************************************
    func stopAnimation() {
        self.layer.shadowOpacity = 0.00
        self.layer.removeAnimation( forKey : "glowingAnimation" )
    }  //func stopAnimation()
    
    //******************************************************************************************************************************
    // VIEW FRAME GLOWS
    //******************************************************************************************************************************

    //***************************************************************
    //***************        func StartPrimaryImageGlow()
    //***************************************************************
    func StartPrimaryImageGlow() {
        if let myColor = GlowColor {
            imageView?.startGlowingWithColor( color : myColor, intensity : GlowIntensity )
        }  // if let myColor = GlowColor
    }  // func StartPrimaryImageGlow()
    
    //***************************************************************
    //***************        func StartCenterImageGlow()
    //***************************************************************
    func StartCenterImageGlow() {
        if let myColor = CIGlowColor {
            CenterImageView.startGlowingWithColor( color : myColor, intensity : CIIntensity )
        }  // if let myColor = CIGlowColor
    }  // func StartCenterImageGlow()
    
    //***************************************************************
    //***************        func StartTLBadgeGlow()
    //***************************************************************
    func StartTLBadgeGlow() {
        if let myColor = TLGlowColor {
            TLBadgeView.startGlowingWithColor( color : myColor, intensity : TLIntensity )
        }  // if let myColor = TLGlowColor
    }  //func StartTLBadgeGlow()
    
    //***************************************************************
    //***************        ffunc StartTRBadgeGlow()
    //***************************************************************
    func StartTRBadgeGlow() {
        if let myColor = TRGlowColor {
            TRBadgeView.startGlowingWithColor( color : myColor, intensity : TRIntensity )
        }  // if let myColor = TRGlowColor
    }  // func StartTRBadgeGlow()
    
    //***************************************************************
    //***************        func StopPrimaryImageGlow()
    //***************************************************************
    func StopPrimaryImageGlow() {
        imageView?.stopGlowing()
    }  // func StopPrimaryImageGlow()
    
    //***************************************************************
    //***************        func StopCenterImageGlow()
    //***************************************************************
    func StopCenterImageGlow() {
        CenterImageView.stopGlowing()
    }  // func StopCenterImageGlow()
    
    //***************************************************************
    //***************        func StopImageAGlow()
    //***************************************************************
    func StopTLBadgeGlow() {
        TLBadgeView.stopGlowing()
    }  // func StopImageAGlow()
    
    //***************************************************************
    //***************        func StopImageBGlow()
    //***************************************************************
    func StopTRBadgeGlow() {
        TRBadgeView.stopGlowing()
    }  // func StopImageBGlow()
    
    //******************************************************************************************************************************
    // EDGE GLOWS
    //******************************************************************************************************************************

    //***************************************************************
    //***************        func StartPrimaryImageGlow()
    //***************************************************************
    func StartPrimaryImageEdgeGlow( addedW : CGFloat, addedH : CGFloat ) {
        if let myColor = GlowColor {
            imageView?.startEdgeGlowingWithColor(color: myColor, addedW : addedW, addedH : addedH, intensity : GlowIntensity )
        }  // if let myColor = GlowColor
    }  // func StartPrimaryImageGlow()
    
    //***************************************************************
    //***************        func StartCenterImageGlow()
    //***************************************************************
    func StartCenterImageEdgeGlow( addedW : CGFloat, addedH : CGFloat ) {
        if let myColor = CIGlowColor {
            CenterImageView.startEdgeGlowingWithColor(color: myColor, addedW : addedW, addedH : addedH, intensity : CIIntensity )
        }  // if let myColor = CIGlowColor
    }  // func StartCenterImageGlow()
    
    //***************************************************************
    //***************        func StartImageAGlow()
    //***************************************************************
    func StartTLBadgeEdgeGlow( addedW : CGFloat, addedH : CGFloat ) {
        if let myColor = TLGlowColor {
            TLBadgeView.startEdgeGlowingWithColor( color: myColor, addedW : addedW, addedH : addedH, intensity : TLIntensity )
        }  // if let myColor = TLGlowColor
    }  // func StartImageAGlow()
    
    //***************************************************************
    //***************        ffunc StartImageBGlow()
    //***************************************************************
    func StartTRBadgeEdgeGlow( addedW : CGFloat, addedH : CGFloat ) {
        if let myColor = TRGlowColor {
            TRBadgeView.startEdgeGlowingWithColor( color: myColor, addedW : addedW, addedH : addedH, intensity : TRIntensity )
        }  // if let myColor = TRGlowColor
    }  // func StartImageBGlow()
    
    //***************************************************************
    //***************        func StopPrimaryImageGlow()
    //***************************************************************
    func StopPrimaryImageEdgeGlow() {
        imageView?.stopEdgeGlowing()
    }  // func StopPrimaryImageGlow()
    
    //***************************************************************
    //***************        func StopCenterImageGlow()
    //***************************************************************
    func StopCenterImageEdgeGlow() {
        CenterImageView.stopEdgeGlowing()
    }  // func StopCenterImageGlow()
    
    //***************************************************************
    //***************        func StopImageAGlow()
    //***************************************************************
    func StopTLBadgeEdgeGlow() {
        TLBadgeView.stopEdgeGlowing()
    }  // func StopImageAGlow()
    
    //***************************************************************
    //***************        func StopImageBGlow()
    //***************************************************************
    func StopTRBadgeEdgeGlow() {
        TRBadgeView.stopEdgeGlowing()
    }  // func StopImageBGlow()
    
}  //class GameButton: UIButton

//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//******************************************  END GameButton.swift
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
