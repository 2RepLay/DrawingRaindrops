//
//  Particle.swift
//  Drawing Canvas
//
//  Created by nikita on 04.03.2023.
//

import SwiftUI

struct Particle {
	
	let position: CGPoint
	let deathDate = Date.now.timeIntervalSinceReferenceDate + 1
	
}
