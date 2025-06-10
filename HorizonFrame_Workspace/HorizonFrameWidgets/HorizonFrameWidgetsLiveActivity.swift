//
//  HorizonFrameWidgetsLiveActivity.swift
//  HorizonFrameWidgets
//
//  Created by Cole Segura on 6/3/25.
//

// import ActivityKit
import WidgetKit
import SwiftUI

/*
struct HorizonFrameWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
*/

/*
struct HorizonFrameWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HorizonFrameWidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
*/

/*
extension HorizonFrameWidgetsAttributes {
    fileprivate static var preview: HorizonFrameWidgetsAttributes {
        HorizonFrameWidgetsAttributes(name: "World")
    }
}
*/

/*
extension HorizonFrameWidgetsAttributes.ContentState {
    fileprivate static var smiley: HorizonFrameWidgetsAttributes.ContentState {
        HorizonFrameWidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HorizonFrameWidgetsAttributes.ContentState {
         HorizonFrameWidgetsAttributes.ContentState(emoji: "🤩")
     }
}
*/

/*
#Preview("Notification", as: .content, using: HorizonFrameWidgetsAttributes.preview) {
   HorizonFrameWidgetsLiveActivity()
} contentStates: {
    HorizonFrameWidgetsAttributes.ContentState.smiley
    HorizonFrameWidgetsAttributes.ContentState.starEyes
}
*/
