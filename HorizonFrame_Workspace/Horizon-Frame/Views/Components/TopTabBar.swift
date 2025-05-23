import SwiftUI

public struct TopTabBar: View {
    @EnvironmentObject private var router: TabRouter
    @Namespace private var underline

    public var body: some View {
        HStack(spacing: 12) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut) { router.current = tab }
                } label: {
                    Text(tab.rawValue.capitalized)
                        .font(.headline)
                        .foregroundColor(router.current == tab ? .black : .white)
                        .padding(.horizontal, 16).padding(.vertical, 8)
                        .background(
                            ZStack {
                                if router.current == tab {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white)
                                        .matchedGeometryEffect(id: "underline", in: underline)
                                } else {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                }
                            }
                        )
                }
                .opacity(router.current == tab ? 1 : 0.6)
            }
        }
        .padding(.top, 8)
    }
}
