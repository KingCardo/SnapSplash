//
//  ToolButtonView.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 10/30/23.
//

import SwiftUI

struct ToolButtonView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 30, height: 30)
    }
}
