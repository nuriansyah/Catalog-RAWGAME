//
//  ContentView.swift
//  Catalog-RAWGAME.io
//
//  Created by Nuriansyah Malik on 08/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fetch = NetworkService()
    var body: some View {
        ZStack {
            TabView{
                List(fetch.network) { game in
                    /*@START_MENU_TOKEN@*/Text(game.slug)/*@END_MENU_TOKEN@*/
                    Text(game.name)
                }
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                ProfileView()
                .tabItem{
                    Label("Profile",systemImage: "person.fill")
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
