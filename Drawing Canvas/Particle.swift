//
//  Particle.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

class Particle {
	
	var x: Double
	var y: Double
	var xSpeed: Double
	var ySpeed: Double
	let deathDate = Date.now.timeIntervalSinceReferenceDate + 2
	
	init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
		self.x = x
		self.y = y
		self.xSpeed = xSpeed
		self.ySpeed = ySpeed
	}
	
}
