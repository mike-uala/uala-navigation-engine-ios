import Foundation

protocol CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { get }
}

extension Mexico: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUMXHelper() }
}

extension Argentina: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUARHelper() }
}

extension Colombia: CoreDependenciesProtocol {
    var clabeCVUHelper: ClabeCVUHelperProtocol { ClabeCVUDefaultHelper() }
}
