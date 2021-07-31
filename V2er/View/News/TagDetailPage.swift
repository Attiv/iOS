//
//  TagDetailPage.swift
//  V2er
//
//  Created by Seth on 2021/7/7.
//  Copyright © 2021 lessmore.io. All rights reserved.
//

import SwiftUI

struct TagDetailPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var statusBarConfigurator = StatusBarConfigurator()
    
    @State private var scrollY: CGFloat = 0.0
    private let heightOfNodeImage = 60.0
    private var shouldHideNavbar: Bool {
        let hideNavbar =  scrollY > -heightOfNodeImage * 1.0
        statusBarConfigurator.statusBarStyle = hideNavbar ? .lightContent : .darkContent
        return hideNavbar
    }
    
    private var foreGroundColor: Color {
        shouldHideNavbar ? .white.opacity(0.9) : .tintColor
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            navBar
                .zIndex(1)
            VStack {
                topBannerView
                nodeListView
            }
            .loadMore {
                return true
            } onScroll: {
                self.scrollY = $0
            }
        }
        .prepareStatusBarConfigurator(statusBarConfigurator)
        .buttonStyle(.plain)
        .ignoresSafeArea(.container)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private var navBar: some View  {
        NavbarHostView(paddingH: 0) {
            HStack(alignment: .center, spacing: 4) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2.weight(.regular))
                        .padding(.leading, 8)
                        .padding(.vertical, 10)
//                        .foregroundColor(.tintColor)
                }
                
                Group {
                    AvatarView(src: "share_node_v2ex", size: 36)
                    VStack(alignment: .leading) {
                        Text("分享创造")
                            .font(.headline)
                        Text("欢迎你在这里发布你的新作品")
                            .font(.subheadline)
                    }
                    .lineLimit(1)
                }
                .opacity(shouldHideNavbar ? 0.0 : 1.0)
                
                Spacer()
                
                Button {
                    // Star the node
                } label: {
                    Image(systemName: "bookmark")
                        .padding(8)
                        .font(.title3.weight(.regular))
//                        .foregroundColor(.tintColor)
                }
                .opacity(shouldHideNavbar ? 0.0 : 1.0)
                
                Button {
                    // Show more actions
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .font(.title3.weight(.regular))
//                        .foregroundColor(.tintColor)
                }
            }
            .padding(.vertical, 5)
        }
        .hideDivider(hide: shouldHideNavbar)
        .visualBlur(alpha: shouldHideNavbar ? 0.0 : 1.0)
        .foregroundColor(foreGroundColor)
    }
    
    
    @ViewBuilder
    private var topBannerView: some View {
        VStack (spacing: 12) {
            Color.clear.frame(height: topSafeAreaInset().top)
            AvatarView(src: "share_node_v2ex", size: heightOfNodeImage)
            Text("分享创造")
                .font(.headline.weight(.semibold))
            Text("欢迎你在这里发布你的新作品")
                .font(.callout)
            HStack {
                Text("16492个主题")
                    .font(.callout)
                Spacer()
                Button {
                    // do star
                } label: {
                    Text("收藏")
                        .font(.callout)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 2)
                        .roundedEdge(radius: 99, borderWidth: 1, color: foreGroundColor)
                }
                Spacer()
                Text("4001个收藏")
                    .font(.callout)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            Divider()
        }
        .foregroundColor(foreGroundColor)
        .foregroundColor(.bodyText)
        .padding(.top, 8)
        .background {
            Image("share_node_v2ex")
                .resizable()
                .blur(radius: 80, opaque: true)
                .overlay(Color.black.opacity(0.3))
        }
        
    }
    
    
    @ViewBuilder
    private var nodeListView: some View {
        ForEach( 0...20, id: \.self) { i in
            NavigationLink(destination: NewsDetailPage()) {
                NewsItemView()
            }
        }
    }
    
}

struct TagDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        TagDetailPage()
    }
}
