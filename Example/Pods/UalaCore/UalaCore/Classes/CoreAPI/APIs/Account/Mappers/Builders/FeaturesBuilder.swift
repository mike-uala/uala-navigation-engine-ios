import Foundation

struct FeaturesBuilder {
    static func features(dto: FeaturesDTO?) -> HomeFeatures? {
        guard let dto = dto else { return nil }
        
        let items = dto.menu.compactMap{ HomeType(rawValue:$0.item) }
        let functionalities = dto.functionalities?.compactMap{ Functionalities(rawValue:$0.functionality) }
        
        return HomeFeatures(items: items, functionalities: functionalities ?? [])
    }
}
