//
//  AttachmentInput.swift
//  UalaSignUp
//
//  Created by Rodrigo German Ferretty on 27/03/2020.
//

import UIKit

public protocol AttachmentInputDelegate {
    func attachmentActionListener(itemSelected:AttachmentInput)
}

public class AttachmentInput: UIView {
    
    @IBOutlet var mainContentView: UIView!
    @IBOutlet weak var attachmentImage: UIImageView!
    @IBOutlet weak var attachmentLabel: UILabel!
    
    public var delegate: AttachmentInputDelegate?
    public var hasPicture = false
    public var attachmentCameraConfig: CameraConfiguration?
    
    public var picture: UIImage?{
        didSet{
            guard let image = picture else{ return }
            self.hasPicture =  true
            self.attachmentImage.image = image
        }
    }
    
    public var labelText: String?{
        didSet{
            self.attachmentLabel.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.nibSetup()
    }
    
    private func nibSetup(){
        loadNib()
        addSubview(mainContentView)
        mainContentView.frame = self.bounds
        mainContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainContentView.autoresizesSubviews = true
        attachmentImage.image = CommonImage(named: "camera")
        setActionAttachmentImage()
    }
    
    func setActionAttachmentImage() {
        //       imageviewObject.image = UIImage.init(named: “Your Icon or Imagev file name”)
        attachmentImage.isUserInteractionEnabled = true
        attachmentImage.isMultipleTouchEnabled = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(self.attachmentImageAction(sender:)))
        
        attachmentImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.mainContentView.layoutIfNeeded()
        addBorder()
    }
    
    public func setContentMode(mode: ContentMode) {
        attachmentImage.contentMode = mode
    }
    
    private func addBorder(){
        let layer = CAShapeLayer()
        let bounds = attachmentImage.layer.bounds
        layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        layer.strokeColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        layer.fillColor = nil
        layer.lineDashPattern = [3, 3]
        attachmentImage.layer.addSublayer(layer)
    }
    
    @objc func attachmentImageAction(sender:UITapGestureRecognizer) {
        guard let listener = delegate else { return }
        listener.attachmentActionListener(itemSelected: self)
    }
}

