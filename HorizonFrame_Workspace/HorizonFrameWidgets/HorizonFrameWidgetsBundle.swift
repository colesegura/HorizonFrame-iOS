//
//  HorizonFrameWidgetsBundle.swift
//  HorizonFrameWidgets
//
//  Created by Cole Segura on 6/3/25.
//

import WidgetKit
import SwiftUI

@main
struct HorizonFrameWidgetsBundle: WidgetBundle {
    var body: some Widget {
        HorizonFrameWidgets()
        HorizonFrameWidgetsControl()
        HorizonFrameWidgetsLiveActivity()
    }
}
