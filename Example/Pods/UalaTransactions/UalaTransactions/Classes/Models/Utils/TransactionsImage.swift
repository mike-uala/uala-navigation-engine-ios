import UIKit
import UalaUI

class TransactionsImage: BundleImage {
    convenience init?(named: String){
        self.init(bundle: .Transactions, named: named)
    }
}
