// import ActivityKit
import WidgetKit
import SwiftUI


/*
struct ScreenTimeLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScreenTimeActivityAttributes.self) { context in
            VStack(alignment: .leading) {
                Text("Screen Time")
                    .font(.headline)
                    .foregroundColor(.white)
                ProgressView(value: context.state.elapsedHours, total: context.attributes.dailyGoal)
                    .progressViewStyle(.linear)
                Text(context.state.insight)
                    .font(.caption)
                    .padding(.top, 2)
            }
            .padding()
            .background(.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded regions
                DynamicIslandExpandedRegion(.leading) {
                    Text("Screen Time")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(String(format: "%.1f", context.state.elapsedHours)) / \(Int(context.attributes.dailyGoal))h")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.insight)
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                }
            } compactLeading: {
                Image(systemName: "timer") // Placeholder icon
                    .foregroundColor(.cyan)
            } compactTrailing: { // Corrected from compactLeading to compactTrailing
                Text("\(String(format: "%.1f", context.state.elapsedHours))h")
                    .foregroundColor(.cyan)
            } minimal: {
                Image(systemName: "timer") // Placeholder icon
                    .foregroundColor(.cyan)
            }
            .widgetURL(URL(string: "horizonframe://screentime")) // Optional: URL to open when tapped
            .keylineTint(.cyan) // Optional: Tint for lines in Dynamic Island
        }
    }
}
*/
// --- Sample usage from the main app ---
/*
let attr = ScreenTimeActivityAttributes(dailyGoal: 4)
let initState = ScreenTimeActivityAttributes.ContentState(elapsedHours: 0, insight: "Stay mindful")
let activity = try? Activity<ScreenTimeActivityAttributes>.request(attributes: attr, contentState: initState)
// Later updates:
Task { await activity?.update(using: .init(elapsedHours: 1.5, insight: "Breathe")) }
*/
