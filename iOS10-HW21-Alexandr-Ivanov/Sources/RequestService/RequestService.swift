import Foundation
import Alamofire

enum RequestType {
    case getAll, search(String)
}

class RequestService {
    typealias URLCompletion = ((inout [URLQueryItem]) -> Void)?
    typealias RequestCompletion = (_ data: [Character]?, _ error: (code: String, message: String)?) -> Void

    // MARK: - Fetch Characters
    func fetchCharacters(requestType: RequestType, completion: @escaping RequestCompletion) {
        var url: URL?

        switch requestType {
        case .getAll:
            url = makeMarvelURL(completion: nil)
        case .search(let name):
            url = makeMarvelURL(completion: { queryItems in
                queryItems.insert(URLQueryItem(name: "nameStartsWith", value: name), at: 0)
            })
        }

        guard let url = url else { return }
        let request = AF.request(url)
        request.responseDecodable(of: CharacterDataWrapper.self) { data in

            guard data.response != nil else {
                completion(nil, ("Ошибка","Проблемы с интернет соединением"))
                return
            }
            
            switch data.result {
            case .success(let data):
                let status = data.status == "Ok" ? nil: data.status

                if let message = data.message == nil ? status: data.message {
                    switch data.code {
                    case .int(let int):
                        completion(nil, (String(int), message))
                    case .string(let string):
                        completion(nil, (string, message))
                    default:
                        return
                    }
                }
                guard let characters = data.data?.results else { return }
                completion(characters, nil)
            case .failure(let error):
                let errorCode = String(error.responseCode ?? 0)
                completion(nil, (errorCode, error.localizedDescription))
            }
        }
    }

    // MARK: - Get Image Data
    
    func getImageData(path: String?, completion: @escaping (Data) -> Void ) {
        guard let url = path else { return }
        AF.download(url).responseData { data in
            guard let image = data.value else {
                return
            }
            completion(image)
        }
    }

    // MARK: - Make URL

    private func makeMarvelURL(completion: URLCompletion) -> URL? {
        var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "gateway.marvel.com"
            urlComponents.path = "/v1/public/characters"
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: "50"),
                URLQueryItem(name: "ts", value: ApplicationSettingsService.Timestamp.timestamp),
                URLQueryItem(name: "apikey", value: ApplicationSettingsService.APIKeys.publicKey),
                URLQueryItem(name: "hash", value: ApplicationSettingsService.getHash())
            ]
            completion?(&urlComponents.queryItems!)
            return urlComponents
        }
        return urlComponents.url
    }
}
