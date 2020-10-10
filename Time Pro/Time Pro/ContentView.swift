//
//  ContentView.swift
//  Time Pro
//
//  Created by Aryan Sharma on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomTabView(
            tabBarPosition: .top,
            content: [
                (
                    tabText: "􀐫 Clock",
                    tabIconName: "icons.general.home",
                    view: AnyView(
                        //TimeView()
                        ClockView().padding().animation(.spring(response: 0.2, dampingFraction: 0.2)).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                ),
                (
                    tabText: "􀐯 Stopwatch",
                    tabIconName: "icons.general.list",
                    view: AnyView(
                        HStack {
                            StopwatchView().padding().animation(.spring(response: 0.2, dampingFraction: 0.2)).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    )
                ),
                (
                    tabText: "􀐱 Timer",
                    tabIconName: "icons.general.cog",
                    view: AnyView(
                        HStack {
                            Text("Work-In-Progress")
                        }
                    )
                )
            ]
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public extension Color {
    
    #if os(macOS)
    static let backgroundColor = Color(NSColor.windowBackgroundColor)
    static let secondaryBackgroundColor = Color(NSColor.controlBackgroundColor)
    #else
    static let backgroundColor = Color(UIColor.systemBackground)
    static let secondaryBackgroundColor = Color(UIColor.secondarySystemBackground)
    #endif
}

public struct CustomTabView: View {
    
    public enum TabBarPosition { // Where the tab bar will be located within the view
        case top
        case bottom
    }
    
    private let tabBarPosition: TabBarPosition
    private let tabText: [String]
    private let tabIconNames: [String]
    private let tabViews: [AnyView]
    
    @State private var selection = 0
    
    public init(tabBarPosition: TabBarPosition, content: [(tabText: String, tabIconName: String, view: AnyView)]) {
        self.tabBarPosition = tabBarPosition
        self.tabText = content.map{ $0.tabText }
        self.tabIconNames = content.map{ $0.tabIconName }
        self.tabViews = content.map{ $0.view }
    }
    
    public var tabBar: some View {
        
        HStack {
            Spacer()
            ForEach(0..<tabText.count) { index in
                HStack {
                    Image(self.tabIconNames[index])
                    Text(self.tabText[index]).font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .foregroundColor(self.selection == index ? Color.accentColor : Color.primary)
                .background(Color.secondaryBackgroundColor)
                .onTapGesture {
                    self.selection = index
                }
            }
            Spacer()
        }
        .padding(0)
        .background(Color.secondaryBackgroundColor) // Extra background layer to reset the shadow and stop it applying to every sub-view
        .shadow(color: Color.clear, radius: 0, x: 0, y: 0)
        .background(Color.secondaryBackgroundColor)
        .shadow(
            color: Color.black.opacity(0.25),
            radius: 3,
            x: 0,
            y: tabBarPosition == .top ? 1 : -1
        )
        .zIndex(99) // Raised so that shadow is visible above view backgrounds
    }
    public var body: some View {
        
        VStack(spacing: 0) {
            
            if (self.tabBarPosition == .top) {
                tabBar
            }
            
            tabViews[selection]
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if (self.tabBarPosition == .bottom) {
                tabBar
            }
        }
        .padding(0)
    }
}
