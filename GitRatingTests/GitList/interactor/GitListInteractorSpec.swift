import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import GitRating

class GitListInteractorSpec: QuickSpec {
    
    override func spec() {
        
        let presenter:InteractorToPresenterProtocolMock = InteractorToPresenterProtocolMock()
        let interactor:GitListInteractor = GitListInteractor()
        interactor.presenter = presenter
        
        describe("GitListInteractorTest class") {
            describe("should fetch list") {
                it("return success and parse") {
                    
                    stub(condition: isHost("api.github.com")) { request in
                        let stubPath = OHPathForFile("repositories_success.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }
                    
                    interactor.fetchGitList(page: 1)
                    expect(presenter.isSuccess).toEventually(beTrue())
                }
                
                it("return success and fail to parse"){
                    stub(condition: isHost("api.github.com")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("repositories_error.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    interactor.fetchGitList(page: 1)
                    expect(presenter.isSuccess).toEventually(beFalse())
                }
                
                it("and return error") {
                    stub(condition: isHost("api.github.com")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("repositories_error.json", type(of: self))!,
                            statusCode: 403,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    interactor.fetchGitList(page: 1)
                    expect(presenter.isSuccess).toEventually(beFalse())
                }
                
            }
            
            afterSuite {
                OHHTTPStubs.removeAllStubs()
            }
        }
    }
    
}

class InteractorToPresenterProtocolMock: InteractorToPresenterProtocol {
    
    var isSuccess:Bool?
    
    func gitListFetched(list: GitListModel) {
        isSuccess = true
    }
    
    func gitListFetchedFailed() {
        isSuccess = false
    }
}
