//
//  TabBar.swift
//  V2er
//
//  Created by Seth on 2020/5/24.
//  Copyright © 2020 lessmore.io. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedId : TabId
    
    var tabs = [TabItem(id: TabId.feed, text: "Feed", icon: "feed_tab"),
                TabItem(id: TabId.explore, text: "Explore", icon: "explore_tab"),
                TabItem(id: TabId.message, text: "Message", icon: "message_tab"),
                TabItem(id: TabId.me, text: "Me", icon: "me_tab")]
    
    var body: some View {
        HStack {
            ForEach (self.tabs, id: \.self) { tab in
                Button(action: {
                    self.selectedId = tab.id
                }) {
                    VStack (spacing: 0) {
                        Capsule()
                            .fill(self.selectedId == tab.id ? Color("indictor") : Color.clear)
                            .frame(height: 2.5)
                            .cornerRadius(0)
                        
                        Image(tab.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 23)
                            .padding(.top, 6)
                            .padding(.bottom, 2)
                        Text(tab.text)
                            .font(.caption)
                    }
                    .foregroundColor(Color(self.selectedId == tab.id ? "selected" : "unselected"))
                    .background(self.bg(isSelected: self.selectedId == tab.id))
                    .padding(.horizontal, 12)
                }
            }
        }
    }
    
    func bg(isSelected : Bool) -> some View {
        return LinearGradient(
            gradient:Gradient(colors: isSelected ?
                [Color(0xBFBFBF, a: 0.2), Color(0xBFBFBF, a: 0.1), Color(0xBFBFBF, a: 0.05), Color(0xBFBFBF, a: 0.01)] : [])
            , startPoint: .top, endPoint: .bottom)
            .padding(.top, 3)
    }
}



enum TabId {
    case feed, explore, message, me
}

class TabItem : Hashable {
    let id : TabId
    var text : String
    var icon : String
    
    init(id: TabId, text : String, icon : String) {
        self.id = id
        self.text = text
        self.icon = icon
    }
    
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct TabBar_Previews : PreviewProvider {
    @State static var selected = TabId.feed
    
    static var previews: some View {
        VStack {
            Spacer()
            TabBar(selectedId: $selected)
                .background(VEBlur())
        }
    }
    
}

