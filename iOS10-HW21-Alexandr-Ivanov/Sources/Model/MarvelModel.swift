import Foundation

enum CodeValue: Decodable {
    case int(Int), string(String)

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw ValueError.missingValue
    }

    enum ValueError: Error {
        case missingValue
    }
}

// MARK: - Model

struct CharacterDataWrapper: Decodable {
    var code: CodeValue?
    var message: String?
    var status: String?
    var data: CharacterDataContainer?

    enum CodingKeys: String, CodingKey {
        case code
        case message
        case status
        case data
    }
}

struct CharacterDataContainer: Decodable {
    var results: [Character]?
}

struct Character: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    var path: String?
    var `extension`: String?

    func getImagePath(with imageSize: String, completion: @escaping (String) -> Void) {
        completion((path ?? "") + "/\(imageSize)." + (`extension` ?? ""))
    }
}
