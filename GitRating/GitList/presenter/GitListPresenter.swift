import Foundation

class GitListPresenter: ViewToPresenterProtocol {

    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol?
    
    var currentPage:Int = 1
    var currentCount:Int = 0
    var total:Int = 1000
    var isFetchInProgress: Bool = false
    
    var repoList:[Item] = []
    
    func fetchGitList() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        interactor?.fetchGitList(page: currentPage)
    }
    
    func refreshGitList() {
        currentPage = 1
        repoList.removeAll()
        currentCount = 0
        interactor?.fetchGitList(page: currentPage)
    }
    
}

extension GitListPresenter: InteractorToPresenterProtocol {

    func gitListFetched(list: GitListModel) {
        isFetchInProgress = false
        currentPage += 1
        currentCount += list.items.count
        //total = list.totalCount // Apesar do contrato retornar o valor total, API retorna apenas os primeiros 1000 repositorios
        repoList.append(contentsOf: list.items)
        
        if currentPage > 2 {
            let indexPathsToReload = self.calculateIndexPathToReload(from: list.items)
            view?.showGitList(with: indexPathsToReload)
        } else {
            view?.showGitList(with: .none)
        }
    }
    
    func gitListFetchedFailed() {
        view?.showError()
    }
    
    func calculateIndexPathToReload(from newItens: [Item]) -> [IndexPath] {
        let startIndex = repoList.count - newItens.count
        let endIndex = startIndex + newItens.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
    }
}

