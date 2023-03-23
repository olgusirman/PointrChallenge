import Foundation
import SwiftUI

struct Log: Identifiable, Hashable {
    var id = UUID()
    var username: String = ""
    var message: String
    var date = Date()

    enum `Type` {
        case log
        case info
        case warning
        case error

        var accentColor: Color {
            switch self {
            case .log:
                return Color.primary
            case .info:
                return Color.yellow
            case .warning:
                return Color.orange
            case .error:
                return Color.red
            }
        }
    }

    static let samples = [Log(message: "First Log"), Log(message: "Second Log")]

}

// TODO: Provide these values if needed
// Country & Region
// Date
// FPS || GPU

class LogModel: ObservableObject {

    @Published var logs: [Log] = Log.samples
}
