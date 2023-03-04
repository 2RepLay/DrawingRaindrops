//
//  ContentView.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var particleSystem = ParticleSystem()
	
    var body: some View {
		TimelineView(.animation) { timeline in
			Canvas { ctx, size in
				let timelineDate = timeline.date.timeIntervalSinceReferenceDate
				particleSystem.update(date: timelineDate)
				
				ctx.blendMode = .plusLighter
				ctx.addFilter(.blur(radius: 10))
				
				for particle in particleSystem.particles {
					ctx.opacity = particle.deathDate - timelineDate
					
					ctx.fill(
						Circle()
							.path(
								in: CGRect(
									x: particle.position.x - 16, 
									y: particle.position.y - 16, 
									width: 32, 
									height: 32
								)
							), 
						with: .color(.cyan)
					)
				}
			}
		}
		.gesture(
			DragGesture(minimumDistance: 0)
				.onChanged { drag in
					particleSystem.position = drag.location
				}
		)
		.ignoresSafeArea()
		.background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
