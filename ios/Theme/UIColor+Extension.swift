//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var mutableHexString = hexString
        if mutableHexString.hasPrefix("#") {
            mutableHexString.removeFirst()
        }
        guard mutableHexString.count == 6 else {
            preconditionFailure("Expected \(hexString) to be formatted as #rrggbb or rrggbb")
        }
        guard let hex = UInt(mutableHexString, radix: 16) else {
            preconditionFailure("\(hexString) is not a valid hex color")
        }
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 08) & 0xff) / 255
        let blue = Double((hex >> 00) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
