import Foundation

struct CardsMapper: MappeableType {
    
    struct Result: Decodable {
        let cards: [CardDTO]
    }
    
    func map<T>(_ data: Data) -> T? {
        return decode(data)?
            .cards
            .compactMap({ CardBuilder.card(dto: $0) }) as? T
    }
}

struct CardMapper: MappeableType {
    
    struct Result: Decodable {
        let card: CardDTO
    }
    
    func map<T>(_ data: Data) -> T? {        
        return CardBuilder.card(dto: decode(data)?.card) as? T
    }
}

/*
 In MEX, the activation WS returns a single card (not an array as in arg):
 https://bancar.atlassian.net/wiki/spaces/UM/pages/1428685093/Activate+Card
 but the app expects an array for both cases. Please do this better :(
 */
struct MxEnableCardMapper: MappeableType {
    
    struct Result: Decodable {
        let card: CardDTO
    }
    
    func map<T>(_ data: Data) -> T? {
        return [CardBuilder.card(dto: decode(data)?.card)] as? T
    }
}
