//
//  FontExtension.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation
import SwiftUI

public enum Fonts: String {
    case montserratBold = "Montserrat-Bold"
    case montserratBoldItalic = "Montserrat-BoldItalic"
    case montserratExtraBold = "Montserrat-ExtraBold"
    case montserratExtraBoldItalic = "Montserrat-ExtraBoldItalic"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratSemiBoldItalic = "Montserrat-SemiBoldItalic"
    case montserratRegular = "Montserrat-Regular"
}

extension Font {
    static func custom(_ name: Fonts, size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }
    
    // MARK: MontserratExtraBold
    static var manropeExtraBold_36: Font {
        return .custom(.montserratExtraBold, size: 36)
    }
    
    static var manropeExtraBold_34: Font {
        return .custom(.montserratExtraBold, size: 34)
    }
    
    static var manropeExtraBold_32: Font {
        return .custom(.montserratExtraBold, size: 32)
    }
    
    static var manropeExtraBold_30: Font {
        return .custom(.montserratExtraBold, size: 30)
    }
    
    static var manropeExtraBold_28: Font {
        return .custom(.montserratExtraBold, size: 28)
    }
    
    static var manropeExtraBold_26: Font {
        return .custom(.montserratExtraBold, size: 26)
    }
    
    // MARK: MontserratBold
    static var manropeBold_36: Font {
        return .custom(.montserratBold, size: 34)
    }
    
    static var manropeBold_34: Font {
        return .custom(.montserratBold, size: 34)
    }
    
    static var manropeBold_32: Font {
        return .custom(.montserratBold, size: 32)
    }
    
    static var manropeBold_30: Font {
        return .custom(.montserratBold, size: 30)
    }
    
    static var manropeBold_28: Font {
        return .custom(.montserratBold, size: 28)
    }
    
    static var manropeBold_26: Font {
        return .custom(.montserratBold, size: 26)
    }
    
    static var manropeBold_24: Font {
        return .custom(.montserratBold, size: 32)
    }
    
    
    // MARK: MontserratSemiBold
    
    static var montserratSemiBold_90: Font {
        return .custom(.montserratSemiBold, size: 90)
    }
    
    static var montserratSemiBold_42: Font {
        return .custom(.montserratSemiBold, size: 42)
    }
    
    static var montserratSemiBold_36: Font {
        return .custom(.montserratSemiBold, size: 36)
    }
    
    static var montserratSemiBold_32: Font {
        return .custom(.montserratSemiBold, size: 32)
    }
    
    static var montserratSemiBold_30: Font {
        return .custom(.montserratSemiBold, size: 30)
    }
    
    static var montserratSemiBold_28: Font {
        return .custom(.montserratSemiBold, size: 28)
    }
    
    static var montserratSemiBold_26: Font {
        return .custom(.montserratSemiBold, size: 26)
    }
    
    static var montserratSemiBold_24: Font {
        return .custom(.montserratSemiBold, size: 24)
    }
    
    static var montserratSemiBold_22: Font {
        return .custom(.montserratSemiBold, size: 22)
    }
    
    static var montserratSemiBold_20: Font {
        return .custom(.montserratSemiBold, size: 20)
    }
    
    static var montserratSemiBold_18: Font {
        return .custom(.montserratSemiBold, size: 18)
    }
    
    static var montserratSemiBold_16: Font {
        return .custom(.montserratSemiBold, size: 16)
    }
    
    static var montserratSemiBold_14: Font {
        return .custom(.montserratSemiBold, size: 14)
    }
    
    static var montserratSemiBold_12: Font {
        return .custom(.montserratSemiBold, size: 12)
    }
    
    // MARK: MontserratRegular
    static var montserratRegular_30: Font {
        return .custom(.montserratRegular, size: 30)
    }
    
    static var montserratRegular_28: Font {
        return .custom(.montserratRegular, size: 28)
    }
    
    static var montserratRegular_26: Font {
        return .custom(.montserratRegular, size: 26)
    }
    
    static var montserratRegular_24: Font {
        return .custom(.montserratRegular, size: 24)
    }
    
    static var montserratRegular_22: Font {
        return .custom(.montserratRegular, size: 22)
    }
    
    static var montserratRegular_20: Font {
        return .custom(.montserratRegular, size: 20)
    }
    
    static var montserratRegular_18: Font {
        return .custom(.montserratRegular, size: 18)
    }
    
    static var montserratRegular_16: Font {
        return .custom(.montserratRegular, size: 16)
    }
    
    static var montserratRegular_14: Font {
        return .custom(.montserratRegular, size: 14)
    }
    
    static var montserratRegular_10: Font {
        return .custom(.montserratRegular, size: 10)
    }
    
    static var montserratRegular_8: Font {
        return .custom(.montserratRegular, size: 8)
    }
}
