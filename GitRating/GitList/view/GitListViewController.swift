import Foundation
import UIKit
import SDWebImage

class GitListViewController: UITableViewController {
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GitListTableViewCell.self, forCellReuseIdentifier: "repoCell")
        tableView.prefetchDataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

    }
    
    @objc func refresh() {
        presenter?.refreshGitList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.fetchGitList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.total ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as? GitListTableViewCell else {
            fatalError("Expected cell to be of type \(GitListTableViewCell.self)")
        }
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            if let repoList = presenter?.repoList {
                cell.configure(with: repoList[indexPath.row])
            }
        }
        
        return cell;
    }
    
}

extension GitListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter?.fetchGitList()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let isLoading = indexPath.row >= presenter?.currentCount ?? 0
        return isLoading
    }
    
}

extension GitListViewController: PresenterToViewProtocol {
    
    func showGitList(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.reloadData()
            if refreshControl?.isRefreshing ?? false {
                refreshControl?.endRefreshing()
            }
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Erro", message: "Falha ao buscar a lista", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: false, completion: nil)
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathIntersection)
    }
    
}
