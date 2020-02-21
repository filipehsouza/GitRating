import Foundation
import UIKit
import Quick
import Nimble
@testable import GitRating

class GitListViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var view: GitListViewController?
        var presenter: ViewToPresenterProtocolMock?
        
        describe("GitListViewController class") {
            
            beforeEach {
                view = GitListViewController()
                presenter = ViewToPresenterProtocolMock()
                view?.presenter = presenter
            }
            
            describe("isLoadingCell", closure: {
                it("should return true", closure: {
                    let indexPath = IndexPath(row: 5, section: 0)
                    let isLoading = view?.isLoadingCell(for: indexPath)
                    expect(isLoading).to(beTrue())
                })
                it("should return false", closure: {
                    view?.presenter?.currentCount = 1
                    let indexPath = IndexPath(row: 0, section: 0)
                    let isLoading = view?.isLoadingCell(for: indexPath)
                    expect(isLoading).to(beFalse())
                })
            })
            
            describe("visibleIndexPathsToReload", closure: {
                it("should return an array", closure: {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let indexPaths = [indexPath]
                    view?.tableView.reloadData()
                    let newIndexPaths = view?.visibleIndexPathsToReload(intersecting: indexPaths)
                    expect(newIndexPaths!.count).to(equal(1))
                })
                it("should return an empty array", closure: {
                    let indexPaths = view?.visibleIndexPathsToReload(intersecting: [IndexPath]())
                    expect(indexPaths?.count).to(equal(0))
                })
                
            })
            
            describe("should call presenter", {
                it("and refresh git list", closure: {
                    view?.refresh()
                    expect(presenter?.isFetch).to(beFalse())
                })
            })
            
            describe("show view ", closure: {
                it("error alert", closure: {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.rootViewController = view
                    window.makeKeyAndVisible()
                    view?.showError()
                    expect(view?.presentedViewController).toEventually(beAnInstanceOf(UIAlertController.self))
                })
            })
        }
    }
}

class ViewToPresenterProtocolMock: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol?
    
    var currentPage: Int = 1
    var currentCount: Int = 0
    var total: Int = 1000
    var repoList: [Item] = [Item]()
    
    var isFetch: Bool?
    
    func fetchGitList() {
        isFetch = true
    }
    
    func refreshGitList() {
        isFetch = false
    }
    
    
}
