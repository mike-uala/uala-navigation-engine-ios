import UIKit
import UalaCore

open class BundleImage: UIImage {
    convenience public init?(bundle: StringTables, named: String) {
        
        let bundle = BundleUtils.getBundle(from: bundle)
        guard let image = UIImage(named: named,
                                  in: bundle,
                                  compatibleWith: nil)?.cgImage else { return nil }
        
        self.init(cgImage: image, scale: UIScreen.main.scale, orientation: .up)
    }
}

public class CommonImage: BundleImage {
    convenience public init?(named: String) {
        self.init(bundle: .Common, named: named)
    }
}
