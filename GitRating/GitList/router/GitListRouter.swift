import Foundation
import UIKit

class GitListRouter: PresenterToRouterProtocol {
    
    static var storyboard: UIStoryboard{
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    class func createModule() -> UIViewController {
        
        guard let view = storyboard.instantiateViewController(withIdentifier: "GitListViewController") as? GitListViewController else {
            fatalError("Expected view to be of type \(GitListViewController.self)")
        }
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = GitListPresenter()
        let interactor: PresentorToInteractorProtocol = GitListInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view;
        
    }
    
}
