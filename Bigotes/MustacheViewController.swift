
import UIKit

class MustacheViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        bigotize()
    }
    
    func bigotize() {
        do {
            try Bigotizer.bigotize(
                JSONFile: "Person",
                mapperName: "PersonMapper",
                destinationEntity: "PersonAPIModel"
            )
        } catch {
        
        }
    }
}

