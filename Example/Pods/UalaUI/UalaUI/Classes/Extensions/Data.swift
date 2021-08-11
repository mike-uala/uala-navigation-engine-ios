//
//  Data.swift
//  UalaUI
//
//  Created by Enzo Digiano on 22/02/2021.
//

import Foundation

extension Data {
    
    /// Related to image, this function allow to clean Hight Efficiency Compression Metadata from .HEIC phone pictures
    /// - Returns: `Data` object or `nil`
    func cleanEXIFMetadata() -> Data? {
        guard let source = CGImageSourceCreateWithData(self as NSData, nil),
              let type = CGImageSourceGetType(source) else {
            return nil
        }

        let count = CGImageSourceGetCount(source)
        let mutableData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(mutableData, type, count, nil) else {
            return nil
        }

        let exifToRemove: CFDictionary = [
            kCGImagePropertyExifDictionary: kCFNull,
            kCGImagePropertyGPSDictionary: kCFNull,
        ] as CFDictionary

        for index in 0 ..< count {
            CGImageDestinationAddImageFromSource(destination, source, index, exifToRemove)
            CGImageDestinationFinalize(destination)
        }

        return mutableData as Data
    }
}
