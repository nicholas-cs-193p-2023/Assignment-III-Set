import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/nicholasdalba/Developer/Set/Set/View/Squiggle.swift", line: 1)
//
//  Squiggle.swift
//  Set
//
//  Created by Nicholas Alba on 8/24/24.
//

import SwiftUI

private struct Constants {
    static let curvePointRadius = 4.0
    static let controlPointRadius = 4.0
}

private struct SquigglePath {
    var minX: CGFloat
    var maxX: CGFloat
    var minY: CGFloat
    var maxY: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    init(in rect: CGRect) {
        minX = rect.minX
        maxX = rect.maxX
        minY = rect.minY
        maxY = rect.maxY
        width = rect.width
        height = rect.height
    }
    
    var curvePoints: [CGPoint] {
        [CGPoint(x: minX, y: minY + __designTimeFloat("#16031_0", fallback: 0.7) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_1", fallback: 0.20) * width, y: minY + __designTimeFloat("#16031_2", fallback: 0.10) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_3", fallback: 0.85) * width, y: minY + __designTimeFloat("#16031_4", fallback: 0.05) * height),
         CGPoint(x: maxX, y: minY + __designTimeFloat("#16031_5", fallback: 0.40) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_6", fallback: 0.60) * width, y: maxY - __designTimeFloat("#16031_7", fallback: 0.05) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_8", fallback: 0.35) * width, y: height - __designTimeFloat("#16031_9", fallback: 0.10) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_10", fallback: 0.10) * width, y: height - __designTimeFloat("#16031_11", fallback: 0.05) * height)]
    }
    
    var controlPoints:  [CGPoint] {
        [CGPoint(x: minX, y: minY),
         CGPoint(x: minX + __designTimeFloat("#16031_12", fallback: 0.60) * width, y: minY + __designTimeFloat("#16031_13", fallback: 0.25) * height),
         CGPoint(x: maxX, y: minY - __designTimeFloat("#16031_14", fallback: 0.05) * height),
         CGPoint(x: maxX, y: maxY),
         CGPoint(x: minX + __designTimeFloat("#16031_15", fallback: 0.50) * width, y: maxY - __designTimeFloat("#16031_16", fallback: 0.05) * height),
         CGPoint(x: minX + __designTimeFloat("#16031_17", fallback: 0.20) * width, y: maxY - __designTimeFloat("#16031_18", fallback: 0.15) * height),
         CGPoint(x: minX, y: maxY + __designTimeFloat("#16031_19", fallback: 0.10) * height)]
    }
}

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let squigglePath = SquigglePath(in: rect)
        let curvePoints = squigglePath.curvePoints
        let controlPoints = squigglePath.controlPoints
                
        var p = Path()
        p.move(to: curvePoints[__designTimeInteger("#16031_20", fallback: 0)])
        for i in __designTimeInteger("#16031_21", fallback: 0)..<curvePoints.count {
            let j = (i + __designTimeInteger("#16031_22", fallback: 1)) % curvePoints.count
            p.addQuadCurve(to: curvePoints[j], control: controlPoints[i])
        }
        
        return p
    }
}

struct CurvePointMarkers: Shape {
    func path(in rect: CGRect) -> Path {
        let squigglePath = SquigglePath(in: rect)
        let curvePoints = squigglePath.curvePoints
        
        var p = Path()
        let radius = Constants.curvePointRadius
        for point in curvePoints {
            p.addEllipse(in: CGRect(x: point.x - radius, y: point.y - radius, width: radius * __designTimeFloat("#16031_23", fallback: 2.0), height: radius * __designTimeFloat("#16031_24", fallback: 2.0)))
        }
        
        return p
    }
}

struct ControlPointMarkers: Shape {
    func path(in rect: CGRect) -> Path {
        let squigglePath = SquigglePath(in: rect)
        let controlPoints = squigglePath.controlPoints
        
        var p = Path()
        let radius = Constants.controlPointRadius
        for point in controlPoints {
            p.addEllipse(in: CGRect(x: point.x - radius, y: point.y - radius, width: radius * __designTimeFloat("#16031_25", fallback: 2.0), height: radius * __designTimeFloat("#16031_26", fallback: 2.0)))
        }
        
        return p
    }
}

struct SquigglePreview: View {
    private let aspectRatio = 2.0
    
    var body: some View {
        squiggle
    }
    
    var squiggle: some View {
        Squiggle().stroke().aspectRatio(aspectRatio, contentMode: .fit).background(.yellow)
            .overlay(CurvePointMarkers().fill(.blue))
            .overlay(ControlPointMarkers().fill(.red))
            .padding()
    }
}

#Preview {
    SquigglePreview()
}

