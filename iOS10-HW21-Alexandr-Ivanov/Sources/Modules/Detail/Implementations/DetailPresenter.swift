import Foundation

class DetailPresenter {
    weak var view: DetailViewInput?
    var router: DetailRouterInput?
    private var imageData: Data?
    private var character: Character?

    init(view: DetailViewInput?, character: Character?, imageData: Data?) {
        self.view = view
        self.imageData = imageData
        self.character = character
    }
}

// MARK: - DetailViewOutput

extension DetailPresenter: DetailViewOutput {
    func loadData() {
        view?.setCharacter(name: character?.name ?? "", description: character?.description ?? "", imageData: imageData ?? Data())
    }
}
