import Foundation
import Alamofire

class GitListInteractor: PresentorToInteractorProtocol {
    
    let endpoint:String = "https://api.github.com/search/repositories"
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchGitList(page:Int) {
        let parameters:[String:String] = ["q":"language:swift", "sort":"stars", "order":"desc", "page":"\(page)"]
        Alamofire.request(endpoint, parameters: parameters).response { (response) in
            
            if (response.response?.statusCode == 200) {
                guard let data = response.data else { return }
                do {
                    let gitListResponse = try JSONDecoder().decode(GitListModel.self, from: data)
                    self.presenter?.gitListFetched(list: gitListResponse)
                } catch {
                    debugPrint(error)
                    self.presenter?.gitListFetchedFailed()
                }
            } else {
                self.presenter?.gitListFetchedFailed()
            }
            
        }
        
    }
    
}
