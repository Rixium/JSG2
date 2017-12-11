package Entity 
{
	
	import Constants.GameManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class DescriptionBox extends MovieClip
	{
		
		var startY:int;
		var moveY = 10;
		var moveSpeed = 0.2;
		var entity:EntityBase
		var currentYOffset = 0;
		var alphaChange = 0.3;
		var fastSpeed = 2;
		var fastY = 20;
		public var dead:Boolean = false;
		
		public function DescriptionBox(t:String, e:EntityBase) 
		{
			box.background = true; 
			box.backgroundColor = 0x000000;
			
			box.text = t;
			box.autoSize = TextFieldAutoSize.CENTER;
			box.width = box.textWidth;
			box.height = box.textHeight;
			alphaChange /= t.length;
			y -= e.height / 2;
			startY = y;
			GameManager.ui.AddDescriptor(this);
			entity = e;
		}
		
		public function Update() {
			x = entity.x;
			y = entity.y - entity.height / 2;
			
			if (box.alpha - alphaChange >= 0) {
				if (currentYOffset < fastY) {
					currentYOffset += fastSpeed;
				} else {
					currentYOffset += moveSpeed;
				}
				y -= currentYOffset;
				box.alpha -= alphaChange;
			} else {
				dead = true;
			}
		}
	}

}