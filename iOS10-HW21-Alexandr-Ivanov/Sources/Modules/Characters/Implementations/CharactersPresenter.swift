import Foundation

class CharactersPresenter {
    typealias ErrorType = (code: String, message: String)?
    weak var view: CharactersViewInput?
    var requestService: RequestService?
    var router: CharactersRouterInput?
    private var characters: [Character] = []

    required init(view: CharactersViewInput) {
        self.view = view
    }

    private func responseHandling(data: [Character]?, error: ErrorType) {
        if let error = error {
            view?.showAlert(code: error.code, message: error.message)
        }
        characters = data ?? []
        view?.reloadData()
    }
}

// MARK: - CharactersViewOutput

extension CharactersPresenter: CharactersViewOutput {
    func presentDetail(at indexPath: IndexPath) {
        let character = characters[indexPath.row]
        
        character.thumbnail?.getImagePath(with: ImageSize.fantastic, completion: { [weak self] path in
            self?.requestService?.getImageData(path: path, completion: { [weak self] data in
                self?.router?.presentDetail(with: character, and: data)
            })
        })
    }

    func getCharacterImage(at indexPath: IndexPath, completion: @escaping (Data) -> Void) {
        characters[indexPath.row].thumbnail?.getImagePath(with: ImageSize.large, completion: { [weak self] path in
            self?.requestService?.getImageData(path: path, completion: { data in
                completion(data)
            })
        })
    }

    func getCharacter(at indexPath: IndexPath) -> Character {
        characters[indexPath.row]
    }

    func getCharactersCount() -> Int {
        characters.count
    }

    func searchCharaters(with name: String) {
        view?.cancelButton(is: true)
        requestService?.fetchCharacters(requestType: .search(name), completion: { [weak self] data, error in
            self?.responseHandling(data: data, error: error)
        })
    }

    func loadData() {
        view?.cancelButton(is: false)
        requestService?.fetchCharacters(requestType: .getAll, completion: { [weak self] data, error in
            self?.responseHandling(data: data, error: error)
        })
    }
}
