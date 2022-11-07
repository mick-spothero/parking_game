import 'libraries/noble/Noble'

import 'utilities/Utilities'

import 'scenes/GameScene'
import 'scenes/TitleScene'
import 'scenes/GameOverScene'

Noble.Settings.setup({
	Difficulty = "Medium"
})

Noble.GameData.setup({
	Score = 0
})

Noble.showFPS = false

Noble.new(TitleScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)

SCORE = 0
