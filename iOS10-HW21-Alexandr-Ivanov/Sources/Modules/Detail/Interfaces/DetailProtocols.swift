import Foundation

// Presenter -> View
protocol DetailViewInput: AnyObject {
    func setCharacter(name: String, description: String, imageData: Data)
}

// View -> Presenter
protocol DetailViewOutput: AnyObject {
    func loadData()
}

// Presenter -> Router
protocol DetailRouterInput: AnyObject {
    
}
