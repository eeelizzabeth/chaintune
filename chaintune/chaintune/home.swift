//
//  home.swift
//  chaintune
//
//  Created by Elizabeth Hernandez on 11/20/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct home: View {
    @EnvironmentObject var session: FirebaseSession
    @State var menuOpen: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    //*************************Grown Plant***************************
                    Image("fruitTree")
                        .resizable().frame(width:250, height: 250)
                        .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.green, lineWidth: 2))
                                    .shadow(radius: 10)
                    
                    //***************************************************************
                    Spacer().frame(height: 200)
                    //*************************Add Icon******************************
                    NavigationLink(destination: createGroup()) {
                        HStack() {
                            Spacer().frame(width: 170)
                            Image("addIcon")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image
                            .TemplateRenderingMode.original))
                            .resizable().frame(width:60, height:60)
                            Spacer().frame(width: 0)
                        }

                    }
                    //***************************************************************
                }.edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("Home")
                
                CircularProgressBar()
                
                SideMenu(width: 270,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
            }
            .navigationBarTitle("")
                //*************************Menu Icon******************************
                .navigationBarItems(leading: Button(action: {
                     self.openMenu()
                    print("menu button pressed!")
                }, label: {
                    Image("barIcon")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image
                        .TemplateRenderingMode.original))
                        .resizable().frame(width:35, height:35)
                
                })
                //****************************************************************
                    //*************************User Icon******************************
                    , trailing: Button(action: {
                        self.session.logOut()
                    }){
                        Text("Logout")
                    }
                    //****************************************************************
            )}
    }
    func openMenu() {
        self.menuOpen.toggle()
    }
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
