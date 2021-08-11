import UIKit
import UalaCore

class AttachmentsReviewView: UIViewController, AttachmentsReviewViewProtocol {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var reviewtitle: UILabel!
    @IBOutlet weak var reviewDescription: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var titleText:String?
    var descriptionText:String?
    var pic:UIImage?
    
    var presenter: AttachmentsReviewPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUpUI(){
        setUpStrings()
        self.picture.image = pic
        self.confirmButton.customize(style: .blueRounder)
        self.cancelButton.customize(style: .clearBlueRounder)
    }
    
    func setUpStrings(){
        self.reviewtitle.text = titleText
        self.reviewDescription.text = descriptionText
        self.cancelButton.setTitle(translate("SELFIE_REVIEW_CANCEL", from: .Common), for: .normal)
        self.confirmButton.setTitle(translate("SELFIE_REVIEW_CONFIRM", from: .Common), for: .normal)
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.presenter?.didTapRetakePicture()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        self.presenter?.reviewConfirm()
    }
}
