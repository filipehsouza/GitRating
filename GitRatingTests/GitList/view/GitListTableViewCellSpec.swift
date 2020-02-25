import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import GitRating

class GitListTableViewCellSpec: QuickSpec {
    
    override func spec() {
        
        describe("GitListTableViewCell class") {
            
            it("should configure an item cell with loading", closure: {
                
                let cell: GitListTableViewCell = GitListTableViewCell()
                
                let owner:Owner = Owner(login: "mock", avatarURL: "mock")
                let item:Item = Item(name: "mock", owner: owner, stargazersCount: 1)
                
                cell.configure(with: item)
                
                expect(cell.gitRepoNameLabel.text).to(equal("mock"))
                expect(cell.gitRepoNameLabel.isHidden).to(beFalse())
                
                expect(cell.gitRepoStartCountLabel.text).to(equal("Stars: 1"))
                expect(cell.gitRepoStartCountLabel.isHidden).to(beFalse())
                
                expect(cell.gitRepoAuthorNameLabel.text).to(equal("mock"))
                expect(cell.gitRepoAuthorNameLabel.isHidden).to(beFalse())
                
            })
            
            it("should configure an empty cell with loading", closure: {
                
                let cell: GitListTableViewCell = GitListTableViewCell()
                
                cell.configure(with: .none)
                
                expect(cell.gitRepoNameLabel.isHidden).to(beTrue())
                expect(cell.gitRepoStartCountLabel.isHidden).to(beTrue())
                expect(cell.gitRepoAuthorNameLabel.isHidden).to(beTrue())
                
            })
        }
        
        describe("GitListTableViewCell view") {
            describe("should have valid snapshot", closure: {
                it("loading view", closure: {
                    let cell: GitListTableViewCell = GitListTableViewCell()
                    cell.configure(with: .none)
                    
                    expect(cell) == snapshot("loadin cell")
                })
                
                it("loaded view", closure: {
                    
                    let cell: GitListTableViewCell = GitListTableViewCell()
                    
                    let owner:Owner = Owner(login: "mock", avatarURL: "mock")
                    let item:Item = Item(name: "mock", owner: owner, stargazersCount: 1)
                    
                    cell.configure(with: item)
                    
                    expect(cell) == snapshot("loaded cell")
                })
            })
        }
    }
}
