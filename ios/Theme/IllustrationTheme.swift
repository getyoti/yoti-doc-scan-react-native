//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import YotiSDKDesign

struct IllustrationTheme: YotiSDKIllustrationTheme, Decodable {
    var arrowUpFromLine: YotiSDKIllustration?
    var cameraExclamationmark: YotiSDKIllustration?
    var checkmark: YotiSDKIllustration?
    var documentExclamationmark: YotiSDKIllustration?
    var documentXmark: YotiSDKIllustration?
    var duplicateIdentityDocumentExclamationmark: YotiSDKIllustration?
    var exclamationmark: YotiSDKIllustration?
    var faceScanEyeLevelGuideline: YotiSDKIllustration?
    var faceScanGuidance: YotiSDKIllustration?
    var faceScanLightingGuideline: YotiSDKIllustration?
    var faceScanOnePersonGuideline: YotiSDKIllustration?
    var identityDocumentExclamationmark: YotiSDKIllustration?
    var identityDocumentScanGuidance: YotiSDKIllustration?
    var identityDocumentXmark: YotiSDKIllustration?
    var landscape: YotiSDKIllustration?
    var passportChipScanExclamationmark: YotiSDKIllustration?
    var passportChipScanGuidance: YotiSDKIllustration?
    var passportChipScanMovementGuideline: YotiSDKIllustration?
    var passportChipScanPlacementGuideline: YotiSDKIllustration?
    var portraitUpsideDown: YotiSDKIllustration?
    var xmark: YotiSDKIllustration?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .arrowUpFromLine) {
            arrowUpFromLine = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .cameraExclamationmark) {
            cameraExclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .checkmark) {
            checkmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .documentExclamationmark) {
            documentExclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .documentXmark) {
            documentXmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .duplicateIdentityDocumentExclamationmark) {
            duplicateIdentityDocumentExclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .exclamationmark) {
            exclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .faceScanEyeLevelGuideline) {
            faceScanEyeLevelGuideline = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .faceScanGuidance) {
            faceScanGuidance = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .faceScanLightingGuideline) {
            faceScanLightingGuideline = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .faceScanOnePersonGuideline) {
            faceScanOnePersonGuideline = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .identityDocumentExclamationmark) {
            identityDocumentExclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .identityDocumentScanGuidance) {
            identityDocumentScanGuidance = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .identityDocumentXmark) {
            identityDocumentXmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .landscape) {
            landscape = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .passportChipScanExclamationmark) {
            passportChipScanExclamationmark = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .passportChipScanGuidance) {
            passportChipScanGuidance = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .passportChipScanMovementGuideline) {
            passportChipScanMovementGuideline = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .passportChipScanPlacementGuideline) {
            passportChipScanPlacementGuideline = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .portraitUpsideDown) {
            portraitUpsideDown = YotiSDKIllustration(illustration)
        }
        if let illustration = try container.decodeIfPresent(Illustration.self, forKey: .xmark) {
            xmark = YotiSDKIllustration(illustration)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case arrowUpFromLine = "arrow_up_from_line"
        case cameraExclamationmark = "camera_exclamationmark"
        case checkmark
        case documentExclamationmark = "document_exclamationmark"
        case documentXmark = "document_xmark"
        case duplicateIdentityDocumentExclamationmark = "duplicate_identity_document_exclamationmark"
        case exclamationmark
        case faceScanEyeLevelGuideline = "face_scan_eye_level_guideline"
        case faceScanGuidance = "face_scan_guidance"
        case faceScanLightingGuideline = "face_scan_lighting_guideline"
        case faceScanOnePersonGuideline = "face_scan_one_person_guideline"
        case identityDocumentExclamationmark = "identity_document_exclamationmark"
        case identityDocumentScanGuidance = "identity_document_scan_guidance"
        case identityDocumentXmark = "identity_document_xmark"
        case landscape
        case passportChipScanExclamationmark = "passport_chip_scan_exclamationmark"
        case passportChipScanGuidance = "passport_chip_scan_guidance"
        case passportChipScanMovementGuideline = "passport_chip_scan_movement_guideline"
        case passportChipScanPlacementGuideline = "passport_chip_scan_placement_guideline"
        case portraitUpsideDown = "portrait_upside_down"
        case xmark
    }
}
