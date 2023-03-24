import Foundation
import SwiftUI

actor LogModel: ObservableObject {

    @Published @MainActor private(set) var logs: [Log] = []

    func executeLogs() async throws {
        let counter = AsyncStream<Log> {
            do {
                let randomSleepTime = UInt64.random(in: 1_000_000..<1_000_000_000)
                try await Task.sleep(nanoseconds:randomSleepTime)

                return [
                    Log(message: "Something happened", type: .log),
                    Log(message: "Info logs", type: .info),
                    Log(message: "Warning logs", type: .warning),
                    Log(message: "Error logs", type: .error)
                ].randomElement()

            } catch {
                return nil
            }
        }

        try await observeLogs(counter: counter)
    }

    @MainActor
    func observeLogs(counter: AsyncStream<Log>) async throws {
        for await selectedLog in counter {
            // TODO: Swap with a better data structure later, currently O(n)
            logs.insert(selectedLog, at: 0)
        }
    }

    @MainActor
    func clear() {
        logs.removeAll()
    }
}

extension LogModel {

    @MainActor
    func log(logType: Log.LogType) {
        switch logType {
        case .log:
            let log = Log(message: "Manuel log added", type: .log)
            logs.insert(log, at: 0)
        case .info:
            let log = Log(message: "Info logs added", type: .info)
            logs.insert(log, at: 0)
        case .warning:
            let log = Log(message: "Warning logs added", type: .warning)
            logs.insert(log, at: 0)
        case .error:
            let log = Log(message: "Error log added", type: .error)
            logs.insert(log, at: 0)
        }
    }
}
