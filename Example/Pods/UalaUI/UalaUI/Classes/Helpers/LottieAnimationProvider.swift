//
//  LottieAnimationProvider.swift
//  UalaUI
//
//  Created by Luis Perez on 06/01/21.
//
import Lottie

public class LottieAnimationProvider {
    public enum Animations: String, CaseIterable {
        case DNIBack
        case DNIFront
        case selfie
        case spinningCircle
        
        init?(id: Int) {
            switch id {
            case 1:
                self = .DNIBack
            case 2:
                self = .DNIFront
            case 3:
                self = .selfie
            case 4:
                self = .spinningCircle
            default:
                return nil
            }
        }
    }
    
    public static let assetsBundle: Bundle? = {
        guard let resourceBundleURL = Bundle(for: LottieAnimationProvider.self).url(forResource: "LottieAssets", withExtension: "bundle"),
            let resourceBundle = Bundle(url: resourceBundleURL) else {
                return nil
        }
        return resourceBundle
    }()
    
    public static func animation(animation: Animations) -> Animation? {
        guard let resourceBundle = self.assetsBundle else {
            return nil
        }
        return Animation.named(animation.rawValue, bundle: resourceBundle)
    }
    
    public static func imageProvider(animation: Animations) -> BundleImageProvider? {
        guard let resourceBundle = self.assetsBundle else {
            return nil
        }
        return BundleImageProvider(bundle: resourceBundle, searchPath: "/images")
    }
}
