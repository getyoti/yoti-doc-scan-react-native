//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import CoreFoundation
import YotiSDKDesign

struct ShapeTheme: YotiSDKShapeTheme, Decodable {
    let buttonBorderWidth: CGFloat
    let buttonCornerRadius: CGFloat
    let containerBorderWidth: CGFloat
    let containerMediumCornerRadius: CGFloat
    let containerLargeCornerRadius: CGFloat
    let inputBorderWidth: CGFloat
    let inputCornerRadius: CGFloat

    private enum CodingKeys: String, CodingKey {
        case buttonBorderWidth = "button_border_width"
        case buttonCornerRadius = "button_corner_radius"
        case containerBorderWidth = "container_border_width"
        case containerMediumCornerRadius = "container_medium_corner_radius"
        case containerLargeCornerRadius = "container_large_corner_radius"
        case inputBorderWidth = "input_border_width"
        case inputCornerRadius = "input_corner_radius"
    }
}
