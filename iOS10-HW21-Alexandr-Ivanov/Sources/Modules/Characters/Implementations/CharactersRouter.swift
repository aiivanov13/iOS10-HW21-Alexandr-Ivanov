import UIKit

class CharactersRouter {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - CharactersRouterInput

extension CharactersRouter: CharactersRouterInput {
    func presentDetail(with character: Character, and imageData: Data) {
        let detail = DetailModule().makeModule(with: character, and: imageData)
        viewController?.present(detail, animated: true)
    }
}
