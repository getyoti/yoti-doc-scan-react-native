//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import YotiSDKDesign

@available(iOS 13, *)
struct IconTheme: YotiSDKIconTheme, Decodable {
    var arrowUpToLine: YotiSDKIcon?
    var bin: YotiSDKIcon?
    var boxedCheckmark: YotiSDKIcon?
    var camera: YotiSDKIcon?
    var checkmark: YotiSDKIcon?
    var digitalIDConnect: YotiSDKIcon?
    var document: YotiSDKIcon?
    var eye: YotiSDKIcon?
    var exclamationmark: YotiSDKIcon?
    var face: YotiSDKIcon?
    var help: YotiSDKIcon?
    var identityDocumentCapture: YotiSDKIcon?
    var info: YotiSDKIcon?
    var largeLeftChevron: YotiSDKIcon?
    var passport: YotiSDKIcon?
    var passportChip: YotiSDKIcon?
    var profile: YotiSDKIcon?
    var rotatingArrows: YotiSDKIcon?
    var smallDownChevron: YotiSDKIcon?
    var smallRightChevron: YotiSDKIcon?
    var sun: YotiSDKIcon?
    var xmark: YotiSDKIcon?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .arrowUpToLine) {
            arrowUpToLine = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .bin) {
            bin = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .boxedCheckmark) {
            boxedCheckmark = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .camera) {
            camera = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .checkmark) {
            checkmark = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .digitalIDConnect) {
            digitalIDConnect = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .document) {
            document = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .eye) {
            eye = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .exclamationmark) {
            exclamationmark = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .face) {
            face = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .help) {
            help = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .identityDocumentCapture) {
            identityDocumentCapture = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .info) {
            info = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .largeLeftChevron) {
            largeLeftChevron = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .passport) {
            passport = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .passportChip) {
            passportChip = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .profile) {
            profile = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .rotatingArrows) {
            rotatingArrows = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .smallDownChevron) {
            smallDownChevron = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .smallRightChevron) {
            smallRightChevron = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .sun) {
            sun = YotiSDKIcon(icon)
        }
        if let icon = try container.decodeIfPresent(Icon.self, forKey: .xmark) {
            xmark = YotiSDKIcon(icon)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case arrowUpToLine = "arrow_up_to_line"
        case bin
        case boxedCheckmark = "boxed_checkmark"
        case camera
        case checkmark
        case digitalIDConnect = "digital_id_connect"
        case document
        case eye
        case exclamationmark
        case face
        case help
        case identityDocumentCapture = "identity_document_capture"
        case info
        case largeLeftChevron = "large_left_chevron"
        case passport
        case passportChip = "passport_chip"
        case profile
        case rotatingArrows = "rotating_arrows"
        case smallDownChevron = "small_down_chevron"
        case smallRightChevron = "small_right_chevron"
        case sun
        case xmark
    }
}
