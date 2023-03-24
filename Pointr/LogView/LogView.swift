import SwiftUI

struct LogView: View {
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss

    // MARK: - ViewModel
    @StateObject var viewModel = LogModel()

    // MARK: - Error
    @State private var lastErrorMessage = "" {
      didSet {
        isDisplayingError = true
      }
    }
    @State var isDisplayingError = false

    // MARK: - View
    var body: some View {
        VStack {
            List(viewModel.logs) { log in
                LogRowView(log: log)
            }
            .listStyle(.plain)
            .refreshable {
                Task {
                    viewModel.clear()
                    try await viewModel.executeLogs()
                }
            }
            .task {
                do {
                    try await viewModel.executeLogs()
                } catch {
                    lastErrorMessage = error.localizedDescription
                }
            }
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
        .alert("Error Happened", isPresented: $isDisplayingError, actions: {
          Button("Ok") {
            dismiss()
          }
        }, message: {
          Text(lastErrorMessage)
        })
    }
}
