//
//  ContentView.swift
//  Time Pro
//
//  Created by Aryan Sharma on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
