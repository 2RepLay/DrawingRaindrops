//
//  GyroscopeManager.swift
//  Drawing Canvas
//
//  Created by nikita on 07.03.2023.
//

import Foundation
import CoreMotion

class GyroscopeManager {
	
	@Published var motionData: MotionData = .zero
	
	private let motionManager = CMMotionManager()
	private var timer: Timer? = nil
	
	init() {
		startGyros()
	}
	
	func startGyros() {
		if motionManager.isGyroAvailable {
			motionManager.gyroUpdateInterval = 1 / 60.0
			motionManager.startGyroUpdates()
				
			timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true, block: { timer in
				if let data = self.motionManager.gyroData {
					let x = data.rotationRate.x
					let y = data.rotationRate.y
					let z = data.rotationRate.z
					
					self.motionData = MotionData(x: x, y: y, z: z)
				}
			})
			
			RunLoop.current.add(timer!, forMode: .default)
		}
	}
	
	func stopGyros() {
		if timer != nil {
			timer?.invalidate()
			timer = nil
			motionManager.stopGyroUpdates()
		}
	}
	
}

struct MotionData {
	
	let x: Double
	let y: Double
	let z: Double
	
	static var zero: MotionData = .init(x: 0, y: 0, z: 0) 
	
}
