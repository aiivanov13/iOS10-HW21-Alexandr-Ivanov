import Foundation

// Presenter -> View
protocol CharactersViewInput: AnyObject {
    func showAlert(code: String, message: String)
    func reloadData()
    func cancelButton(is enabled: Bool)
}

// View -> Presenter
protocol CharactersViewOutput: AnyObject {
    func loadData()
    func searchCharaters(with name: String)
    func getCharacterImage(at indexPath: IndexPath, completion: @escaping (Data) -> Void)
    func getCharactersCount() -> Int
    func getCharacter(at indexPath: IndexPath) -> Character
    func presentDetail(at indexPath: IndexPath)
}

// Presenter -> Router
protocol CharactersRouterInput: AnyObject {
    func presentDetail(with character: Character, and imageData: Data)
}
