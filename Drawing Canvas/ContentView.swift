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
		LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom).mask({ 
			TimelineView(.animation) { timeline in
				Canvas { ctx, size in
					let timelineDate = timeline.date.timeIntervalSinceReferenceDate
					particleSystem.update(date: timelineDate, size: size)
					
					ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
					ctx.addFilter(.blur(radius: 10))
					
					ctx.drawLayer { ctx in
						for particle in particleSystem.particles {
							ctx.opacity = particle.deathDate - timelineDate
							
							ctx.fill(
								Circle()
									.path(
										in: CGRect(
											x: particle.x, 
											y: particle.y, 
											width: 32, 
											height: 32
										)
									), 
								with: .color(.white)
							)
						}
					}
				}
			}
			
		})
		.ignoresSafeArea()
		.background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
