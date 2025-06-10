import SwiftUI

/// Wraps AlignmentPlayer + completion/streak screen.
struct AlignmentPlayerContainer: View {
    let session: Session
    var onFinished: () -> Void

    @Environment(\.dismiss) var dismiss
    @State private var finished = false

    var body: some View {
        ZStack {
            if finished {
                AlignmentCompleteView {
                    onFinished()
                    self.dismiss()
                }
            } else {
                AlignmentPlayerView(session: session) {
                    finished = true
                }
            }
        }
    }
}
