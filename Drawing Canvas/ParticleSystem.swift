//
//  ParticleSystem.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import Foundation
import Combine

class ParticleSystem {
	
	var particles = [Particle]()
	var lastUpdate = Date.now.timeIntervalSinceReferenceDate
	
	private var gyroManager = GyroscopeManager()
	private var disposeBag: Set<AnyCancellable> = []
	
	private var currentPosition: MotionData = .zero
	
	init() {
		gyroManager.$motionData.sink { data in
			self.updateSpeed(data)
		}.store(in: &disposeBag)
	}
	
	private func updateSpeed(_ motionData: MotionData) {
		self.currentPosition = .init(
			x: currentPosition.x + motionData.x, 
			y: currentPosition.y + motionData.y, 
			z: currentPosition.z + motionData.z
		)
		
		for particle in particles {
			particle.xSpeed += -motionData.z * 10
			
			if particle.xSpeed > 500 {
				particle.xSpeed = 500
			}
			
			if particle.xSpeed < -500 {
				particle.xSpeed = -500
			}
		}
	}
	
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
			xSpeed: .random(in: -50...50) - currentPosition.z * 10, 
			ySpeed: .random(in: 100...500)
		)
		
		particles.append(newParticle)
	}
	
}
