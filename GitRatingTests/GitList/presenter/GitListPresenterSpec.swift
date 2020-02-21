import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import GitRating

class GitListPresenterSpec: QuickSpec {
    
    override func spec() {
        
        var view: PresenterToViewProtocolMock = PresenterToViewProtocolMock()
        var interactor:PresentorToInteractorProtocolMock = PresentorToInteractorProtocolMock()
        let presenter = GitListPresenter()
        presenter.interactor = interactor
        presenter.view = view
        
        describe("GitListPresenter class") {
            
            beforeEach {
                view = PresenterToViewProtocolMock()
                interactor = PresentorToInteractorProtocolMock()
                presenter.interactor = interactor
                presenter.view = view
            }
            
            describe("should fetch git list") {
                it("and isFetchInProgress is false") {
                    presenter.fetchGitList()
                    expect(interactor.isSuccess).to(beTrue())
                }
                
                it("and isFetchInProgress is true") {
                    presenter.fetchGitList()
                    expect(interactor.isSuccess).to(beFalse())
                }
            }
            
            it("should refresh git list") {
                presenter.refreshGitList()
                expect(interactor.isSuccess).to(beTrue())
            }
            
            describe("should show view") {
                describe("success with") {
                    it("currentPage < 2") {
                        let itens = [Item(name: "mock", owner: Owner(login: "mock", avatarURL: "mock"), stargazersCount: 1)]
                        let listModel = GitListModel(totalCount: 1, incompleteResults: false, items: itens)
                        
                        presenter.gitListFetched(list: listModel)
                        
                        expect(view.isSuccess).to(beTrue())
                        expect(view.indexPaths).to(beNil())
                    }
                    
                    it("currentPage > 2") {
                        let itens = [Item(name: "mock", owner: Owner(login: "mock", avatarURL: "mock"), stargazersCount: 1)]
                        let listModel = GitListModel(totalCount: 1, incompleteResults: false, items: itens)
                        
                        presenter.currentPage = 3
                        presenter.gitListFetched(list: listModel)
                        
                        expect(view.isSuccess).to(beTrue())
                        expect(view.indexPaths).toNot(beNil())
                    }
                }
                
                it("error") {
                    presenter.gitListFetchedFailed()
                    expect(view.isSuccess).to(beFalse())
                }
                
            }
            
            it("should calculate indexPath to reload") {
                let item1 = Item(name: "mock1", owner: Owner(login: "mock1", avatarURL: "mock1"), stargazersCount: 1)
                let item2 = Item(name: "mock2", owner: Owner(login: "mock2", avatarURL: "mock2"), stargazersCount: 2)
                
                let itens = [item1,item2]
                let newItens = [item2]
                
                presenter.repoList = itens
                
                let calculatedItens = presenter.calculateIndexPathToReload(from: newItens)
                
                expect(calculatedItens).toNot(beNil())
                expect(calculatedItens).to(equal([IndexPath(row: 1, section: 0)]))
            }

        }
        
    }
    
}

class PresenterToViewProtocolMock: PresenterToViewProtocol {
    
    var isSuccess:Bool?
    var indexPaths:[IndexPath]?
    
    func showGitList(with newIndexPathsToReload: [IndexPath]?) {
        isSuccess = true
        indexPaths = newIndexPathsToReload
    }
    
    func showError() {
        isSuccess = false
    }
    
}

class PresentorToInteractorProtocolMock: PresentorToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    var isSuccess:Bool = false
    
    func fetchGitList(page: Int) {
        isSuccess = true
    }
    
    
}
