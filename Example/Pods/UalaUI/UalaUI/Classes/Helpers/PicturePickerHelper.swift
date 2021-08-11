import Foundation

public protocol PicturePickerDelegate: class {
    func picturePicker(didFinishPickcing image: UIImage, type: UIImagePickerController.SourceType)
}

public class PicturePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak public var delegate: PicturePickerDelegate?
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.editedImage] as? UIImage {
            self.delegate?.picturePicker(didFinishPickcing: pickerImage, type: picker.sourceType)
            picker.dismiss(animated: true)
        } else if let pickerImage = info[.originalImage] as? UIImage {
            self.delegate?.picturePicker(didFinishPickcing: pickerImage, type: picker.sourceType)
            picker.dismiss(animated: true)
        }
    }
}
