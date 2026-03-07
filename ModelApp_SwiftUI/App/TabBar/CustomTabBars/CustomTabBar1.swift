//
//  CustomTabBar1.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 24/02/26.
//

import SwiftUI



struct CustomTabBar1: View {
    @Binding var selectedTab: AppTab
    @Namespace private var animation // For the sliding indicator

    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                TabBarItem(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    animation: animation,
                    iconName: iconName(for: tab),
                    title: tabName(for: tab)
                ) {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        }
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }

    // Helpers to keep body clean
    func iconName(for tab: AppTab) -> String {
        switch tab {
        case .home: return "house"
        case .settings: return "gearshape"
        }
    }

    func tabName(for tab: AppTab) -> String {
        switch tab {
        case .home: return "HOME"
        case .settings: return "SETUP"
        }
    }
}

private struct TabBarItem: View {
    let tab: AppTab
    let isSelected: Bool
    var animation: Namespace.ID
    let iconName: String
    let title: String
    let onTap: () -> Void
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: isSelected ? iconName + ".fill" : iconName)
                .font(.system(size: 20, weight: .light))
                .symbolEffect(.bounce, value: isSelected)

            if isSelected {
                Text(title)
                    .font(.system(size: 10, weight: .bold))
                    .capsuleIndicator()
                    .matchedGeometryEffect(id: "tab", in: animation)
            } else {
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
        .padding(.horizontal, 4)
    }
}

// MARK: - Capsule Indicator Modifier
private struct CapsuleIndicator: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                Capsule(style: .continuous)
                    .fill(Color.accentColor.opacity(0.15))
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.accentColor.opacity(0.35), lineWidth: 1)
            )
            .foregroundStyle(.primary)
    }
}

private extension View {
    /// Adds a subtle capsule background and stroke around the content, used for the selected tab label.
    func capsuleIndicator() -> some View {
        modifier(CapsuleIndicator())
    }
}



//#Preview {
//    CustomTabBar1(selectedTab: .constant(AppTab.home))
//}
