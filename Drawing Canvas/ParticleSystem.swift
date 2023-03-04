//
//  ParticleSystem.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import Foundation

class ParticleSystem {
	
	var particles = [Particle]()
	var position = CGPoint.zero
	
	func update(date: TimeInterval) {
		particles = particles.filter { $0.deathDate > date }
		particles.append(Particle(position: position))
	}
	
}
