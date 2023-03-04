//
//  ParticleSystem.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import Foundation

class ParticleSystem {
	
	var particles = [Particle]()
	var lastUpdate = Date.now.timeIntervalSinceReferenceDate
	
	func update(date: TimeInterval, size: CGSize) {
		let delta = date - lastUpdate
		lastUpdate = date
		
		for (index, particle) in particles.enumerated() {
			if particle.deathDate < date {
				particles.remove(at: index)
			} else {
				particle.x += particle.xSpeed * delta
				particle.y += particle.ySpeed * delta
			}
		}
		
		let newParticle = Particle(
			x: .random(in: -32...size.width), 
			y: -32, 
			xSpeed: .random(in: -50...50), 
			ySpeed: .random(in: 100...500)
		)
		
		particles.append(newParticle)
	}
	
}
