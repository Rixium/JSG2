package Items 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	 import Constants.GameManager;
	 import flash.display.MovieClip;
	 import flash.events.Event;
	 import flash.events.KeyboardEvent;
	 import fl.transitions.Tween;
	 import fl.transitions.easing.*;
	 import flash.text.TextField;
	 import Sounds.ItemFindSound;
	 import flash.media.SoundChannel;
	 import flash.media.SoundTransform;
	 import flash.text.TextFormat;
	 import Constants.ItemTypes;
	 
	public class ItemPickupAnimation extends MovieClip
	{
		
		var item:Item;
		
		public function ItemPickupAnimation(item:Item) 
		{
			this.item = item;
			this.x = GameManager.main.stage.stageWidth / 2;
			this.y = GameManager.main.stage.stageHeight / 2;
			itemLayer.addChild(item);
			GameManager.ui.addChild(this);
			addEventListener("Finished", RemoveFromStage);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			
			var itemGetText:MovieClip = getChildByName("itemGetText") as MovieClip;
			var itemDesText:MovieClip = getChildByName("itemDesText") as MovieClip;
			
			var textBox:TextField = itemGetText.getChildByName("itemGetText") as TextField;
			textBox.text = item.displayName;
			
			var textBox2:TextField = itemDesText.getChildByName("itemGetText") as TextField;
			
			
			if (item.itemType == ItemTypes.WEAPON) {
				var wep:WeaponItem = item as WeaponItem;
				textBox2.text = "Damage +" + wep.power + "\n" + wep.description;
				wep = null;
			} else {
				textBox2.text = item.description;
			}
			var f:TextFormat = textBox2.getTextFormat();
			f.size = 20;
			textBox2.setTextFormat(f);
			
			var itemFindSound:ItemFindSound = new ItemFindSound();;
			var trans:SoundTransform = new SoundTransform(GameManager.soundLevel, 0); 
			var channel:SoundChannel = itemFindSound.play(0, 1, trans);
			itemFindSound = null;
			trans = null;
			channel = null;
				
			itemGetText = null;
			textBox = null;
		}
		
		public function RemoveFromStage(e:Event) {
			GameManager.sean.GetInventory().AddItem(item, true);
			item = null;
			GameManager.ui.removeChild(this);
			GameManager.sean.StartIdle();
			removeEventListener("Finished", RemoveFromStage);
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.focus = GameManager.gameScreen.GetRoom();
		}
		
		public function KeyDown(e:Event) {
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			gotoAndPlay("Finish");
		}
	}

}