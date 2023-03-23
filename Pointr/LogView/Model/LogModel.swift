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
            logs.insert(selectedLog, at: 0)
        }
    }

    @MainActor
    func clear() {
        logs.removeAll()
    }
}
