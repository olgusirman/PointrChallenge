import SwiftUI

struct Log: Identifiable, Hashable {
    let id: UUID
    let message: String
    let type: Log.LogType
    var dateString: String {
        logDateFormatter.string(from: date)
    }

    private let date: Date

    init(id: UUID = UUID(), message: String, type: Log.LogType = .log, date: Date = Date()) {
        self.id = id
        self.message = message
        self.type = type
        self.date = date
    }

    enum LogType {
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

        var systemImageName: String {
            switch self {
            case .log:
                return "arrow.down.message"
            case .info:
                return "info.bubble"
            case .warning:
                return "exclamationmark.circle"
            case .error:
                return "exclamationmark.shield"
            }
        }
    }

    static let samples = [Log(message: "First Log"), Log(message: "Second Log")]

}
