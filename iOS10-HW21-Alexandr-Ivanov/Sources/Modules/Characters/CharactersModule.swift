import UIKit

final class CharactersModule {
    func makeModule() -> UIViewController {
        let viewController = CharactersView()
        let presenter = CharactersPresenter(view: viewController)
        let router = CharactersRouter(viewController: viewController)
        let requestService = RequestService()
        viewController.presenter = presenter
        presenter.requestService = requestService
        presenter.router = router

        return viewController
    }
}
