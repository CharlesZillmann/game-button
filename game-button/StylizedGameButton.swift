/*************************************************************************
 MIT License
 
 Copyright (c) 2019  StylizedGameButton.swift Charles Zillmann charles.zillmann@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *************************************************************************/

/*************************************************************************
 This file is contains a the code to stylize game buttons.
 
 Use this class to:
 1) Create a set of common game button styles to be used in your app.
 2) Set glow attibutes for the desired effect
 3) Choose your images for each button, each button center image, each badge image
 4) Handle button display state changes
 5) Choose which display features and capabilities of the GameButton to use for each state
*************************************************************************/

import UIKit

//***************************************************************
//***************        enum ButtonGraphicType : Int
//***************************************************************
enum ButtonGraphicType : Int {
    case PurpleBadge
    case GreenBadge
    case BlueprintBadge
    case WetAsphaltBadge
    case GoldBadge
    case AsusBlueGreyBadge
    case RedBadge
    case WhiteBadge
    case BlackBadge
    
    case House
    case Planet
    case Rose
    
    case Badge1
    case Badge2
    case Badge3
    case Badge4
}  // enum ButtonGraphicType : Int

//***************************************************************
//***************        enum ButtonStyle : Int
//***************************************************************
enum ButtonStyle : Int {
    case Style1
    case Style2
    case Style3
    case Style4
}  // enum ButtonStyle : Int

//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
//***************        class StylizedGameButton: GameButton
//*******************************************************************************************
//*******************************************************************************************
//*******************************************************************************************
class StylizedGameButton: GameButton {
    var btnGraphicType      : ButtonGraphicType         = ButtonGraphicType.GoldBadge
    var btnUserGlowState    : Int                       = -1
    
    //***************************************************************
    //***************        override init(frame: CGRect)
    //***************************************************************
    override init(frame: CGRect) {
        super.init(frame: frame)
    }  //override init(frame: CGRect)
    
    //***************************************************************
    //***************        required init?(coder aDecoder: NSCoder)
    //***************************************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }  //required init?(coder aDecoder: NSCoder)
    
    //***************************************************************
    //***************        func setPrimaryImage(thePrimaryGraphic : ButtonGraphicType)
    //***************************************************************
    func setPrimaryImage(thePrimaryGraphic : ButtonGraphicType) {
        self.setImage(getGameImage( theGraphic : thePrimaryGraphic ), for: .normal)
    }  // func setPrimaryImage(thePrimaryGraphic : ButtonGraphicType)
    
    //***************************************************************
    //***************        func setCenterImage(thePrimaryGraphic : ButtonGraphicType)
    //***************************************************************
    func setCenterImage(thePrimaryGraphic : ButtonGraphicType) {
        self.CenterImage = getGameImage( theGraphic : thePrimaryGraphic )
    }  // func setCenterImage(thePrimaryGraphic : ButtonGraphicType)
    
    //***************************************************************
    //***************        func setTLBadgeViewImage(thePrimaryGraphic : ButtonGraphicType)
    //***************************************************************
    func setTLBadgeViewImage(thePrimaryGraphic : ButtonGraphicType) {
        self.TLImage = getGameImage( theGraphic : thePrimaryGraphic )
    }  // func setTLBadgeViewImage(thePrimaryGraphic : ButtonGraphicType)
    
    //***************************************************************
    //***************        func setTRBadgeViewImage(thePrimaryGraphic : ButtonGraphicType)
    //***************************************************************
    func setTRBadgeViewImage(thePrimaryGraphic : ButtonGraphicType) {
        self.TRImage = getGameImage( theGraphic : thePrimaryGraphic )
    }  // func setTRBadgeViewImage(thePrimaryGraphic : ButtonGraphicType)
    
    //***************************************************************
    //***************        func getGameImage( theGraphic : ButtonGraphicType ) -> UIImage
    //***************************************************************
    func getGameImage( theGraphic : ButtonGraphicType ) -> UIImage {
        switch theGraphic {
        case ButtonGraphicType.PurpleBadge          :
            return GameBadge.imageOfPurpleBadge
        case ButtonGraphicType.GreenBadge           :
            return GameBadge.imageOfGreenBadge
        case ButtonGraphicType.BlueprintBadge       :
            return GameBadge.imageOfBlueprintBadge
        case ButtonGraphicType.WetAsphaltBadge      :
            return GameBadge.imageOfWetAsphaltBadge
        case ButtonGraphicType.GoldBadge            :
            return GameBadge.imageOfGoldBadge
        case ButtonGraphicType.AsusBlueGreyBadge    :
            return GameBadge.imageOfAsusBlueGreyBadge
        case ButtonGraphicType.RedBadge             :
            return GameBadge.imageOfRedBadge
        case ButtonGraphicType.WhiteBadge           :
            return GameBadge.imageOfWhiteBadge
        case ButtonGraphicType.BlackBadge           :
            return GameBadge.imageOfBlackBadge
            
        case ButtonGraphicType.Planet:
            return GameBadge.imageOfNA
            
        case ButtonGraphicType.Rose          :
            return GameBadge.imageOfNA
        case ButtonGraphicType.House                :
            if let myImage : UIImage = UIImage(named:"House") {
                return myImage
            } else {
                return GameBadge.imageOfNA
            }
            
        case ButtonGraphicType.Badge1        :
            return GameBadge.imageOfBadge1
        case ButtonGraphicType.Badge2        :
            return GameBadge.imageOfBadge2
        case ButtonGraphicType.Badge3        :
            return GameBadge.imageOfBadge3
        case ButtonGraphicType.Badge4        :
            return GameBadge.imageOfBadge4

        }  //switch btnGraphicType
        
    }  // func getGameImage( theGraphic : ButtonGraphicType ) -> UIImage
    
    //***************************************************************
    //***************        func setupCustomizedButtons()
    //***************************************************************
    func setButtonStyle( btnstyle : ButtonStyle) {
        
        switch btnstyle {
            
        case ButtonStyle.Style1 :
            //GameButton Glowing effect Properties
            GlowDuration     = 3
            GlowCornerRadius = 5
            GlowColor        = UIColor.red
            GlowMaxSize      = 16
            GlowMinSize      = 0
            GlowTopInset     = 5
            GlowBottomInset  = 4
            GlowLeftInset    = 3
            GlowRightInset   = 3
            
            //Center Image
            CIGlowColor    = UIColor.red
            CITopInset     = 0
            CIBottomInset  = 0
            CILeftInset    = 20
            CIRightInset   = 20
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 25
            TL_h_pct      = 25
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 25
            TR_h_pct      = 25
            
            setPrimaryImage(        thePrimaryGraphic : ButtonGraphicType.GoldBadge )
            setCenterImage(         thePrimaryGraphic : ButtonGraphicType.House )
            setTLBadgeViewImage(    thePrimaryGraphic : ButtonGraphicType.Badge4 )
            setTRBadgeViewImage(    thePrimaryGraphic : ButtonGraphicType.Badge4 )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
            
        case .Style2:
            //GameButton Glowing effect Properties
            GlowDuration     = 3
            GlowCornerRadius = 5
            GlowColor        = UIColor.red
            GlowMaxSize      = 16
            GlowMinSize      = 0
            GlowTopInset     = 5
            GlowBottomInset  = 4
            GlowLeftInset    = 3
            GlowRightInset   = 3
            
            //Center Image
            CIGlowColor    = UIColor.red
            CITopInset     = -10
            CIBottomInset  = 0
            CILeftInset    = 20
            CIRightInset   = 20
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 25
            TL_h_pct      = 25
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 25
            TR_h_pct      = 25
            
            setPrimaryImage(        thePrimaryGraphic   : ButtonGraphicType.WhiteBadge  )
            setCenterImage(         thePrimaryGraphic   : ButtonGraphicType.House       )
            setTLBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            setTRBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
            
        case .Style3:
            //GameButton Glowing effect Properties
            GlowDuration     = 3
            GlowCornerRadius = 5
            GlowColor        = UIColor.red
            GlowMaxSize      = 16
            GlowMinSize      = 0
            GlowTopInset     = 5
            GlowBottomInset  = 4
            GlowLeftInset    = 3
            GlowRightInset   = 3
            
            //Center Image
            CIGlowColor    = UIColor.red
            CITopInset     = 0
            CIBottomInset  = 0
            CILeftInset    = 20
            CIRightInset   = 20
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 25
            TL_h_pct      = 25
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 20
            TR_h_pct      = 20
            
            setPrimaryImage(        thePrimaryGraphic   : ButtonGraphicType.BlackBadge  )
            setCenterImage(         thePrimaryGraphic   : ButtonGraphicType.House      )
            setTLBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            setTRBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
            
        case .Style4: //gold
            //GameButton Glowing effect Properties
            GlowDuration     = 3
            GlowCornerRadius = 5
            GlowColor        = UIColor.yellow
            GlowMaxSize      = 16
            GlowMinSize      = 0
            GlowTopInset     = 5
            GlowBottomInset  = 4
            GlowLeftInset    = 3
            GlowRightInset   = 3
            
            //Center Image
            CIGlowColor    = UIColor.yellow
            CITopInset     = -8
            CIBottomInset  = 0
            CILeftInset    = 20
            CIRightInset   = 20
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 25
            TL_h_pct      = 25
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 25
            TR_h_pct      = 25
            
            setPrimaryImage(        thePrimaryGraphic   : ButtonGraphicType.GoldBadge   )
            setCenterImage(         thePrimaryGraphic   : ButtonGraphicType.House       )
            setTLBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            setTRBadgeViewImage(    thePrimaryGraphic   : ButtonGraphicType.Badge4      )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
            
//            layer.borderWidth = 1
//            layer.borderColor = UIColor.black.cgColor
        }  // switch btnstyle
        
    }  // func setupCustomizedButtons()
    
    //***************************************************************
    //***************        func changeState()
    //***************************************************************
    func changeState() {
        
        func resetAll(){
            GlowEnabled = false
            StopPrimaryImageEdgeGlow()
            StopCenterImageEdgeGlow()
            StopTLBadgeEdgeGlow()
            StopTRBadgeEdgeGlow()
            TLBadgeisHidden = true
            TRBadgeisHidden = true
        }  // func resetAll()
        
        resetAll()
        
        switch btnUserGlowState {
        case 0:
            //Glow Button Frame
            GlowEnabled      = true
            btnUserGlowState += 1
        case 1:
            //Glow Button Image
            self.imageView?.shakeOnXAxis()
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            btnUserGlowState += 1
        case 2:
            //Glow Button Center Image
            self.CenterImageView.rotate360Degrees()
            self.CenterImageView.shakeOnYAxis()
            StartCenterImageEdgeGlow( addedW : 7.0, addedH : 7.0 )
            btnUserGlowState += 1
        case 3:
            //Show Button Top Left Badge Image
            TLBadgeisHidden = false
            self.CenterImageView.explode() {
                self.CenterImageView.isHidden = false
                self.TLBadgeView.shakeOnXAxis()
            }
            btnUserGlowState += 1
        case 4:
            //Show & Glow Top Left Badge Image
            TLBadgeisHidden = false
            self.TLBadgeView.shakeOnXAxis()
            StartTLBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 5:
            //Show Button Top Right Badge Image
            TRBadgeisHidden = false
            self.CenterImageView.breakGlass() {
                self.CenterImageView.isHidden   = false
                self.TRBadgeView.shakeOnXAxis()
            }
            btnUserGlowState += 1
        case 6:
            //Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
            self.TRBadgeView.shakeOnXAxis()
            StartTRBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 7:
            //Glow Button Image AND Show & Glow Top Left Badge Image
            TLBadgeisHidden = false
            self.TLBadgeView.shakeOnXAxis()
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            StartTLBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 8:
            //Glow Button Image AND Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
            self.TRBadgeView.shakeOnXAxis()
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            StartTRBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 9:
            //Glow Button Center Image AND Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
            self.TRBadgeView.shakeOnXAxis()
            StartTRBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            StartCenterImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            btnUserGlowState += 1
        default:
            btnUserGlowState = 0
        }  // switch btnUserGlowState
        
    }  // func changeState()
    
}  // class StylizedGameButton : GameButton

//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//******************************************  END StylizedGameButton.swift
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
//*************************************************************************************************************************
