import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import GitRating

class ExtensionSpec: QuickSpec {
    
    override func spec() {
        
        describe("UIView Extension") {
            
            it("should set constraints to the view", closure: {
                
                let superview:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                let view: UILabel = UILabel()
                
                superview.addSubview(view)
                
                view.anchor(top: superview.topAnchor, left: superview.leftAnchor, bottom: superview.bottomAnchor, right: superview.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
                
                superview.layoutIfNeeded()
                
                expect(view.frame.width).to(equal(superview.frame.width))
                expect(view.frame.height).to(equal(superview.frame.height))
            })
            
        }
    }
}
