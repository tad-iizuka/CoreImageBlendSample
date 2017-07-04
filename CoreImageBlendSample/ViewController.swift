//
//  ViewController.swift
//  CoreImageBlendSample
//
//  Created by Tadashi on 2017/07/04.
//  Copyright © 2017 UBUNIFU Incorporated. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	@IBOutlet weak var imageView1: UIImageView!
	@IBOutlet weak var imageView2: UIImageView!
	@IBOutlet weak var imageView3: UIImageView!

	let blendFilterList = [
		"CIAdditionCompositing",
		"CIColorBlendMode",
		"CIColorBurnBlendMode",
		"CIColorDodgeBlendMode",
		"CIDarkenBlendMode",
		"CIDifferenceBlendMode",
		"CIDivideBlendMode",
		"CIExclusionBlendMode",
		"CIHardLightBlendMode",
		"CIHueBlendMode",
		"CILightenBlendMode",
		"CILinearBurnBlendMode",
		"CILinearDodgeBlendMode",
		"CILuminosityBlendMode",
		"CIMaximumCompositing",
		"CIMinimumCompositing",
		"CIMultiplyBlendMode",
		"CIMultiplyCompositing",
		"CIOverlayBlendMode",
		"CIPinLightBlendMode",
		"CISaturationBlendMode",
		"CIScreenBlendMode",
		"CISoftLightBlendMode",
		"CISourceAtopCompositing",
		"CISourceInCompositing",
		"CISourceOutCompositing",
		"CISourceOverCompositing",
		"CISubtractBlendMode" ]

	var dngImage1 : CIImage!
	var dngImage2 : CIImage!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.dngImage1 = self.getImageFromRAW(url:
			URL(fileURLWithPath: Bundle.main.path(forResource: "1", ofType: "dng")!))
		self.dngImage2 = self.getImageFromRAW(url:
			URL(fileURLWithPath: Bundle.main.path(forResource: "2", ofType: "dng")!))
		self.imageView1.image = UIImage.init(ciImage: self.dngImage1)
		self.imageView2.image = UIImage.init(ciImage: self.dngImage2)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getImageFromRAW(url: URL) -> CIImage? {
		let f = CIFilter(imageURL: url, options:nil)
		return	f!.outputImage
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return	1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return	blendFilterList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		cell.textLabel?.text = blendFilterList[indexPath.row]
		
		return cell
	}

	func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		
		DispatchQueue.main.async {
			let f = CIFilter(name: self.blendFilterList[indexPath.row])
			f?.setValue(self.dngImage1, forKey: kCIInputImageKey)
			f?.setValue(self.dngImage2, forKey: kCIInputBackgroundImageKey)
			let image = UIImage.init(ciImage: (f?.outputImage)!)
			self.imageView3.image = image
		}
	}
}

