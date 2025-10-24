//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

struct Configuration: Decodable {
    let singleFlow: Bool?
    let includeIdentityDocumentModuleType: Bool?
    let includeSupplementaryDocumentModuleType: Bool?
    let includeFaceTecModuleType: Bool?
    let includeFaceCaptureModuleType: Bool?
    let disableIdentityDocumentCaptureEdgeDetection: Bool?
    let theme: Theme?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        singleFlow = try container.decodeIfPresent(Bool.self, forKey: .singleFlow)
        includeIdentityDocumentModuleType = try container.decodeIfPresent(Bool.self, forKey: .includeIdentityDocumentModuleType)
        includeSupplementaryDocumentModuleType = try container.decodeIfPresent(Bool.self, forKey: .includeSupplementaryDocumentModuleType)
        includeFaceTecModuleType = try container.decodeIfPresent(Bool.self, forKey: .includeFaceTecModuleType)
        includeFaceCaptureModuleType = try container.decodeIfPresent(Bool.self, forKey: .includeFaceCaptureModuleType)
        disableIdentityDocumentCaptureEdgeDetection = try container.decodeIfPresent(Bool.self, forKey: .disableIdentityDocumentCaptureEdgeDetection)
        theme = try container.decodeIfPresent(Theme.self, forKey: .theme)
    }

    private enum CodingKeys: String, CodingKey {
        case singleFlow = "single_flow"
        case includeIdentityDocumentModuleType = "include_identity_document_module_type"
        case includeSupplementaryDocumentModuleType = "include_supplementary_document_module_type"
        case includeFaceTecModuleType = "include_facetec_module_type"
        case includeFaceCaptureModuleType = "include_face_capture_module_type"
        case disableIdentityDocumentCaptureEdgeDetection = "disable_identity_document_capture_edge_detection"
        case theme
    }
}

extension Configuration {
    init(fileConfiguration: FileConfiguration) {
        let bundleIdentifier = fileConfiguration.bundleIdentifier ?? ""
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            preconditionFailure("Unable to locate bundle with identifier: \(bundleIdentifier)")
        }
        let filename = fileConfiguration.filename ?? ""
        guard let url = bundle.url(forResource: filename, withExtension: nil), let data = try? Data(contentsOf: url) else {
            preconditionFailure("Unable to locate file with name: \(filename)")
        }
        guard let configuration = try? JSONDecoder().decode(Self.self, from: data) else {
            preconditionFailure("Unable to decode configuration")
        }
        self = configuration
    }
}
