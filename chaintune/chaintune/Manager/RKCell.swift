//
//  RKCell.swift
//  chaintune
//
//  Created by Juhi on 12/7/19.
//  Copyright © 2019 Iris Manriquez. All rights reserved.
//

import SwiftUI

struct RKCell: View {
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .background(rkDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
    }
}

struct RKCell_Previews: PreviewProvider {
    static var previews: some View {
        RKCell(rkDate: RKDate(date: Date(), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
            .previewDisplayName("Control")    }
}
