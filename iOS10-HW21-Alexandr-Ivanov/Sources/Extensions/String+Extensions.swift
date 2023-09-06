import Foundation
import CryptoKit

extension String {
    var md5: String {
       Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}

extension String {
    var date: String {
        let formatterGet = DateFormatter()
        formatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm:ss"

        guard let date = formatterGet.date(from: self) else { return "" }

        if date == Date(timeIntervalSince1970: .zero) {
            return "No data"
        }

        return formatter.string(from: date)
    }
}
