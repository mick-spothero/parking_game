import 'libraries/noble/Noble'

import 'utilities/Utilities'

import 'scenes/GameScene'
import 'scenes/TitleScene'

Noble.Settings.setup({
	Difficulty = "Medium"
})

Noble.GameData.setup({
	Score = 0
})

Noble.showFPS = true

Noble.new(TitleScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)