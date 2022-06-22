//
//  ContentView.swift
//  CatalystForm
//
//  Created by Will Bishop on 14/4/2022.
//

import SwiftUI

struct ContentView: View {
	
	@State var iconSelection = 0
	
	var body: some View {
		Spacer()
		HStack {
			Spacer()
			Form {
				Picker("Notify Me About:", selection: $iconSelection) {
					Text("Direct Messages").tag(0)
					Text("Mentions").tag(1)
					Text("Anything").tag(2)
				}
				
				Button("Clear Image Cache") {}
			}
			Spacer()
		}
		Spacer()
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
