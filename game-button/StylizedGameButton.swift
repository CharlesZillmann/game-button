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
    case drawPurpleBadge
    case drawGreenBadge
    case drawBlueprintBadge
    case drawWetAsphaltBadge
    case drawGoldBadge
    case drawAsusBlueGreyBadge
    case drawRedBadge
    case drawWhiteBadge
    case drawBlackBadge
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
    var btnGraphicType      : ButtonGraphicType         = ButtonGraphicType.drawGoldBadge
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
        case ButtonGraphicType.drawPurpleBadge          :
            return GameBadge.imageOfPurpleBadge
        case ButtonGraphicType.drawGreenBadge           :
            return GameBadge.imageOfGreenBadge
        case ButtonGraphicType.drawBlueprintBadge       :
            return GameBadge.imageOfBlueprintBadge
        case ButtonGraphicType.drawWetAsphaltBadge      :
            return GameBadge.imageOfWetAsphaltBadge
        case ButtonGraphicType.drawGoldBadge            :
            return GameBadge.imageOfGoldBadge
        case ButtonGraphicType.drawAsusBlueGreyBadge    :
            return GameBadge.imageOfAsusBlueGreyBadge
        case ButtonGraphicType.drawRedBadge             :
            return GameBadge.imageOfRedBadge
        case ButtonGraphicType.drawWhiteBadge           :
            return GameBadge.imageOfWhiteBadge
        case ButtonGraphicType.drawBlackBadge           :
            return GameBadge.imageOfBlackBadge
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
            CITopInset     = 20
            CIBottomInset  = 20
            CILeftInset    = 20
            CIRightInset   = 20
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 20
            TL_h_pct      = 20
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 20
            TR_h_pct      = 20
            
            setPrimaryImage(thePrimaryGraphic: ButtonGraphicType.drawGoldBadge)
            setCenterImage(thePrimaryGraphic: ButtonGraphicType.drawWhiteBadge)
            setTLBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawGreenBadge)
            setTRBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawRedBadge )
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
            CITopInset     = 5
            CIBottomInset  = 5
            CILeftInset    = 5
            CIRightInset   = 5
            
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
            
            setPrimaryImage(thePrimaryGraphic: ButtonGraphicType.drawPurpleBadge)
            setCenterImage(thePrimaryGraphic: ButtonGraphicType.drawWhiteBadge)
            setTLBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawGoldBadge)
            setTRBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawRedBadge )
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
            CITopInset     = 10
            CIBottomInset  = 10
            CILeftInset    = 10
            CIRightInset   = 10
            
            //A1 Image
            TLGlowColor   = UIColor.red
            TL_x          = 0
            TL_y          = 0
            TL_w_pct      = 30
            TL_h_pct      = 30
            
            //B2 Image
            TRGlowColor   = UIColor.red
            TR_x          = 0
            TR_y          = 0
            TR_w_pct      = 30
            TR_h_pct      = 30
            
            setPrimaryImage(thePrimaryGraphic: ButtonGraphicType.drawBlackBadge)
            setCenterImage(thePrimaryGraphic: ButtonGraphicType.drawGoldBadge)
            setTLBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawGoldBadge)
            setTRBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawRedBadge )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
        case .Style4:
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
            CITopInset     = 15
            CIBottomInset  = 15
            CILeftInset    = 15
            CIRightInset   = 15
            
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
            
            setPrimaryImage(thePrimaryGraphic: ButtonGraphicType.drawGreenBadge)
            setCenterImage(thePrimaryGraphic: ButtonGraphicType.drawWhiteBadge)
            setTLBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawAsusBlueGreyBadge)
            setTRBadgeViewImage(thePrimaryGraphic: ButtonGraphicType.drawRedBadge )
            CIisHidden         = false
            TLBadgeisHidden    = false
            TRBadgeisHidden    = false
            setupGameButtonImageViews()
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
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            btnUserGlowState += 1
        case 2:
            //Glow Button Center Image
            StartCenterImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            btnUserGlowState += 1
        case 3:
            //Show Button Top Left Badge Image
            TLBadgeisHidden = false
            btnUserGlowState += 1
        case 4:
            //Show & Glow Top Left Badge Image
            TLBadgeisHidden = false
            StartTLBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 5:
            //Show Button Top Right Badge Image
            TRBadgeisHidden = false
            btnUserGlowState += 1
        case 6:
            //Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
            StartTRBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 7:
            //Glow Button Image AND Show & Glow Top Left Badge Image
            TLBadgeisHidden = false
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            StartTLBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 8:
            //Glow Button Image AND Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
            StartPrimaryImageEdgeGlow( addedW : 14.0, addedH : 14.0 )
            StartTRBadgeEdgeGlow( addedW : 10.0, addedH : 10.0 )
            btnUserGlowState += 1
        case 9:
            //Glow Button Center Image AND Show & Glow Top Right Badge Image
            TRBadgeisHidden = false
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
