import Foundation
import SwiftUI

actor LogModel: ObservableObject {

    @Published @MainActor private(set) var logs: [Log] = []

    private var sleep: (UInt64) async throws -> Void = Task.sleep(nanoseconds:)

    func executeLogs() async throws {
        let sleep = self.sleep
        var countdown: UInt = 40

        let counter = AsyncStream<Log> {
            do {
                try await sleep(1_000_000_000)

                defer { countdown -= 1 }

                let randomLog = UInt.random(in: 1..<countdown)

                switch randomLog {
                case (0...10):
                    return Log(message: "Something happened", type: .log)
                case (11...20):
                    return Log(message: "Info logs", type: .info)
                case (21...30):
                    return Log(message: "Warning logs", type: .warning)
                case (31...40):
                    return Log(message: "Error logs", type: .error)
                default:
                    return nil
                }

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
}
