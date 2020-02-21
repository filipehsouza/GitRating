import Foundation
import UIKit

protocol PresenterToViewProtocol: class {
    func showGitList(with newIndexPathsToReload: [IndexPath]?)
    func showError()
}

protocol InteractorToPresenterProtocol: class {
    func gitListFetched(list: GitListModel)
    func gitListFetchedFailed()
}

protocol PresentorToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchGitList(page:Int)
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresentorToInteractorProtocol? {get set}
    var currentPage:Int {get set}
    var currentCount:Int {get set}
    var total:Int {get set}
    var repoList:[Item] {get set}
    func fetchGitList()
    func refreshGitList()
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}
