//
//  StartView.swift
//  CodingChallenge
//
//  Created by Edgar on 25.09.22.
//

import SwiftUI

struct StarsView: View {
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<5) { _ in
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
