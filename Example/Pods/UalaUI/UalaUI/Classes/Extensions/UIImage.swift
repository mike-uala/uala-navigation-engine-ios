//
//  UIImage.swift
//  Uala
//
//  Created by Developer on 7/30/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension UIImage {
    
    var isSelfieValid: Bool {
        
        // create a face detector - since speed is not an issue we'll use a high accuracy
        guard let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracyHigh: CIDetectorAccuracy]) else { return false }
        
        // draw a CI image with the previously loaded face detection picture
        guard let cgImage = self.cgImage else { return false }
        
        // create an array containing all the detected faces from the detector
        let features = detector.features(in: CIImage(cgImage: cgImage))
        
        return features.count == 1
    }
    
    func crop(size: CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = size.width / size.height
        
        var cropWidth: CGFloat = size.width
        var cropHeight: CGFloat = size.height
        
        if size.width > size.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if size.width < size.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            } else { //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x : posX, y : posY, width : cropWidth, height : cropHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        cropped.draw(in: CGRect(x : 0, y : 0, width : size.width, height : size.height))
        
        return cropped
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func resize(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func toBase64JpgString(with compression: CGFloat = 1) -> String {
        let imageData: Data = self.jpegData(compressionQuality: compression)! as Data
        if let cleanedImage = imageData.cleanEXIFMetadata() {
            return cleanedImage.base64EncodedString()
        }
        return imageData.base64EncodedString()
    }
    
    func toBase64String() -> String {
        let imageData: Data = self.pngData()! as Data
        return imageData.base64EncodedString()
    }
    
    func getFileSizeInfo(allowedUnits: ByteCountFormatter.Units = .useMB,
                         countStyle: ByteCountFormatter.CountStyle = .file) -> String? {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.countStyle = countStyle
        return getSizeInfo(formatter: formatter)
    }

    func getFileSize(allowedUnits: ByteCountFormatter.Units = .useMB,
                     countStyle: ByteCountFormatter.CountStyle = .memory) -> Double? {
        guard let number = getFileSizeInfo(allowedUnits: allowedUnits, countStyle: countStyle)?.replacingOccurrences(of: ",", with: ".").split(separator: " ").first else { return nil }
        return Double(number)
    }

    func getSizeInfo(formatter: ByteCountFormatter, compressionQuality: CGFloat = 1.0) -> String? {
        guard let imageData = jpegData(compressionQuality: compressionQuality) else { return nil }
        return formatter.string(fromByteCount: Int64(imageData.count))
    }
}

