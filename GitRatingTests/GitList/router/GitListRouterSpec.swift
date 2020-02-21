import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import GitRating

class GitListRouterSpec: QuickSpec {
    
    override func spec() {
        
        describe("GitListRouter class ") {
            
            it("should return an GitListViewController instance", closure: {
                let viewController = GitListRouter.createModule()
                expect(viewController).to(beAnInstanceOf(GitListViewController.self))
            })

        }
    }
}
