import Foundation

class ApplicationSettingsService {

    enum APIKeys {
        static let publicKey = "723d6f5dff37f9143059dbd05970bfcc"
        fileprivate static let privateKey = "0f4102a4697711c82d2c2ff842952d3baa8aca51"
    }

    enum Timestamp {
        static let timestamp = DateFormatter().string(from: Date())
    }

    static func getHash() -> String {
        (Timestamp.timestamp + APIKeys.privateKey + APIKeys.publicKey).md5
    }
}
