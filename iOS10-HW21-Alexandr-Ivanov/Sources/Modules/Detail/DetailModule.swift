import UIKit

final class DetailModule {
    func makeModule(with character: Character, and imageData: Data) -> UIViewController {
        let viewController = DetailView()
        let presenter = DetailPresenter(view: viewController, character: character, imageData: imageData)
        let router = DetailRouter(viewController: viewController)
        viewController.presenter = presenter
        presenter.router = router
        return viewController
    }
}
