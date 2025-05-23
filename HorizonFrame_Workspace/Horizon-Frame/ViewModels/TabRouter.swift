import SwiftUI

public enum Tab: String, CaseIterable { case align, collect, progress, settings }

@MainActor
public final class TabRouter: ObservableObject { @Published public var current: Tab = .align }
