package Helpers 
{
	/**
	 * ...
	 * @author ...
	 */
	import Constants.Keys;
	import Constants.GameManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class TutorialManager extends MovieClip
	{
		
		var tutorials:Array;
		
		var current:int = 0;
		var currentText:TutorialText;
		public var finished:Boolean = false;
		
		public function TutorialManager() 
		{
			tutorials = new Array(
				new TutorialText(this, "Up", Keys.UP, "", true),
				new TutorialText(this, "Down", Keys.DOWN, "", true),
				new TutorialText(this, "Left", Keys.LEFT, "", true),
				new TutorialText(this, "Right", Keys.RIGHT, "", true),
				new TutorialText(this, "Sprint", Keys.SPRINT, "", true),
				new TutorialText(this, "Use", Keys.USE, "", true),
				new TutorialText(this, "Roll", Keys.ROLL, "", true),
				new TutorialText(this, "Bag", Keys.BAG, "", true),
				new TutorialText(this, "Close Bag", Keys.BAG, "", true),
				new TutorialText(this, "Attack", 0, "Left Click", true)
			);
		}
		
		public function start() {
			currentText = tutorials[current] as TutorialText;
			currentText.Initialize();
			GameManager.ui.addChild(currentText);
			current++;
		}
		
		public function next() {
			GameManager.ui.removeChild(currentText);
			if (!finished) {
				if (current == tutorials.length) {
					finished = true;
				} else {
					currentText = tutorials[current] as TutorialText;
					currentText.Initialize();
					GameManager.ui.addChild(currentText);
					current++;
				}
			}
		}
		
	}

}