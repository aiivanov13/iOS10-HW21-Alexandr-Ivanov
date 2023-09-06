import UIKit

class DetailRouter {
    weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - DetailRouterInput

extension DetailRouter: DetailRouterInput {

}
