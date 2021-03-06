﻿ package Screens {
	
	import Helpers.Slider;
	import Sounds.HurtOne;
	import Sounds.MenuMusic;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageQuality;
	import Constants.GameManager;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.text.TextField;
	import Constants.Keys;
	import flash.ui.Mouse;
	import flash.system.System;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.filters.BitmapFilterQuality;
	import Constants.RoomNames;
	
	public class Menu extends Screen {
		
		var mainMenu:MainMenu;
		var channel:SoundChannel = new SoundChannel();
		
		var glow:GlowFilter = new GlowFilter(); 
		var keyGetter:KeyGetter = new KeyGetter();
		var upActive:Boolean, leftActive:Boolean, downActive:Boolean, rightActive:Boolean, sprintActive:Boolean, useActive:Boolean, canClick:Boolean = true;
		var oneActive:Boolean, twoActive:Boolean, threeActive:Boolean, fourActive:Boolean, fiveActive:Boolean, sixActive:Boolean, sevenActive:Boolean, eightActive:Boolean, nineActive:Boolean;
		var rollActive:Boolean, bagActive:Boolean, pauseActive:Boolean;
		
		var firstTimeKeys:Boolean = true, firstTimeOptions:Boolean = true;
		var trans:SoundTransform;
		var menuMusic:MenuMusic = new MenuMusic();
		var started:Boolean = false;
		
		public function Menu(main:Main) {
			this.main = main;
			main.addEventListener("menuready", MenuReady);
			mainMenu = new MainMenu();
			mainMenu.x = 640;
			mainMenu.y = 360;
			AddToStage(mainMenu);
			addEventListener(Event.ENTER_FRAME, Update);
			
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM; 
			GameManager.ResetManager();
			RoomNames.Reset();
			trans = new SoundTransform(GameManager.musicLevel, 0); 
			channel = menuMusic.play(0, 1, trans);
		}
		
		private function adStarted() {
			started = true;
		}
		
		private function adEnded() {	
			removeEventListener(Event.ENTER_FRAME, Update);
			RemoveFromStage(mainMenu);
			main.SetScreen(new GameScreen());
			main = null;
		}

		private function MenuReady(e:Event):void {
			mainMenu.getChildByName("playButton").addEventListener(MouseEvent.CLICK, StartGame);
			mainMenu.getChildByName("optionsButton").addEventListener(MouseEvent.CLICK, ShowOptions);
		}
		
		private function StartGame(e:MouseEvent):void {
			channel.stop();
			RequestAd();
			if (!started) {
				adEnded();
			}
		}
		
		public function RequestAd():void {
            try {
				
            } catch(error:Error) {
                trace("Error, cannot trigger ad, reason:" + error.message);
            }
        }
		
		private function ShowOptions(e:MouseEvent):void {
			
			
			mainMenu.gotoAndStop("options");
			mainMenu.getChildByName("pooButton").addEventListener(MouseEvent.CLICK, PooQuality);
			mainMenu.getChildByName("diamondButton").addEventListener(MouseEvent.CLICK, DiamondQuality);
			mainMenu.getChildByName("keyBindings").addEventListener(MouseEvent.CLICK, CleanAndGoKeys);
			
			if (GameManager.allowFlashing) {
				mainMenu.getChildByName("lightFlickerOn").filters = [glow];
			} else {
				mainMenu.getChildByName("lightFlickerOff").filters = [glow];
			}
			
			(mainMenu.getChildByName("soundSlider") as Slider).Initialize(GameManager.soundLevel);
			(mainMenu.getChildByName("musicSlider") as Slider).Initialize(GameManager.musicLevel);
			
			mainMenu.getChildByName("lightFlickerOn").addEventListener(MouseEvent.CLICK, FlickerOn);
			mainMenu.getChildByName("lightFlickerOff").addEventListener(MouseEvent.CLICK, FlickerOff);
			mainMenu.backButton.addEventListener(MouseEvent.CLICK, CleanAndGoMain);
		}
		
		private function FlickerOn(e:MouseEvent) {
			GameManager.allowFlashing = true;
			if (GameManager.allowFlashing) {
				mainMenu.getChildByName("lightFlickerOn").filters = [glow];
				mainMenu.getChildByName("lightFlickerOff").filters = null;
			} else {
				mainMenu.getChildByName("lightFlickerOn").filters = null;
				mainMenu.getChildByName("lightFlickerOff").filters = [glow];
			}
		}
		
		private function FlickerOff(e:MouseEvent) {
			GameManager.allowFlashing = false;
			if (GameManager.allowFlashing) {
				mainMenu.getChildByName("lightFlickerOn").filters = [glow];
				mainMenu.getChildByName("lightFlickerOff").filters = null;
			} else {
				mainMenu.getChildByName("lightFlickerOn").filters = null;
				mainMenu.getChildByName("lightFlickerOff").filters = [glow];
			}
		}
		
		private function Update(e:Event):void {
			
			if (mainMenu.currentLabel == "options") {
				if (GameManager.soundLevel != (mainMenu.getChildByName("soundSlider") as Slider).sliderPosition) {
					GameManager.soundLevel = (mainMenu.getChildByName("soundSlider") as Slider).sliderPosition;
					var trans2:SoundTransform = new SoundTransform(GameManager.soundLevel, 0);
					var c2 = new HurtOne().play(0, 0, trans2);
					trans2 = null;
					c2 = null;
				}
				if (GameManager.musicLevel != (mainMenu.getChildByName("musicSlider") as Slider).sliderPosition) {
					GameManager.musicLevel = (mainMenu.getChildByName("musicSlider") as Slider).sliderPosition;
					trans.volume = GameManager.musicLevel;
					channel.soundTransform = trans;
				}
			}
			
			if (keyGetter.GetKey() != -1) {
				if (upActive) {
					Keys.UP = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var upKey:TextField = mainMenu.getChildByName("upKey") as TextField;
					upKey.text = Keys.KeyToChar[Keys.UP];
					upKey = null;
					canClick = true;
					upActive = false;
				} else if (downActive) {
					Keys.DOWN = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var downKey:TextField = mainMenu.getChildByName("downKey") as TextField;
					downKey.text = Keys.KeyToChar[Keys.DOWN];
					downKey = null;
					canClick = true;
					downActive = false;
				} else if (leftActive ) {
					Keys.LEFT = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var leftKey:TextField = mainMenu.getChildByName("leftKey") as TextField;
					leftKey.text = Keys.KeyToChar[Keys.LEFT];
					leftKey = null;
					canClick = true;
					leftActive = false;
				} else if (rightActive) {
					Keys.RIGHT = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var rightKey:TextField = mainMenu.getChildByName("rightKey") as TextField;
					rightKey.text = Keys.KeyToChar[Keys.RIGHT];
					rightKey = null;
					canClick = true;
					rightActive = false;
				} else if (sprintActive) {
					Keys.SPRINT = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var sprintKey:TextField = mainMenu.getChildByName("sprintKey") as TextField;
					sprintKey.text = Keys.KeyToChar[Keys.SPRINT];
					sprintKey = null;
					canClick = true;
					sprintActive = false;
				} else if (useActive) {
					Keys.USE = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var useKey:TextField = mainMenu.getChildByName("useKey") as TextField;
					useKey.text = Keys.KeyToChar[Keys.USE];
					useKey = null;
					canClick = true;
					useActive = false;
				} else if (oneActive) {
					Keys.slots[0] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var oneKey:TextField = mainMenu.getChildByName("oneKey") as TextField;
					oneKey.text = Keys.KeyToChar[Keys.slots[0]];
					oneKey = null;
					canClick = true;
					oneActive = false;
				} else if (twoActive) {
					Keys.slots[1] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var twoKey:TextField = mainMenu.getChildByName("twoKey") as TextField;
					twoKey.text = Keys.KeyToChar[Keys.slots[1]];
					twoKey = null;
					canClick = true;
					twoActive = false;
				} else if (threeActive) {
					Keys.slots[2] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var threeKey:TextField = mainMenu.getChildByName("threeKey") as TextField;
					threeKey.text = Keys.KeyToChar[Keys.slots[2]];
					threeKey = null;
					canClick = true;
					threeActive = false;
				} else if (fourActive) {
					Keys.slots[3] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var fourKey:TextField = mainMenu.getChildByName("fourKey") as TextField;
					fourKey.text = Keys.KeyToChar[Keys.slots[3]];
					fourKey = null;
					canClick = true;
					fourActive = false;
				} else if (fiveActive) {
					Keys.slots[4]= keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var fiveKey:TextField = mainMenu.getChildByName("fiveKey") as TextField;
					fiveKey.text = Keys.KeyToChar[Keys.slots[4]];
					fiveKey = null;
					canClick = true;
					fiveActive = false;
				} else if (sixActive) {
					Keys.slots[5] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var sixKey:TextField = mainMenu.getChildByName("sixKey") as TextField;
					sixKey.text = Keys.KeyToChar[Keys.slots[5]];
					sixKey = null;
					canClick = true;
					sixActive = false;
				} else if (sevenActive) {
					Keys.slots[6] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var sevenKey:TextField = mainMenu.getChildByName("sevenKey") as TextField;
					sevenKey.text = Keys.KeyToChar[Keys.slots[6]];
					sevenKey = null;
					canClick = true;
					sevenActive = false;
				} else if (eightActive) {
					Keys.slots[7] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var eightKey:TextField = mainMenu.getChildByName("eightKey") as TextField;
					eightKey.text = Keys.KeyToChar[Keys.slots[7]];
					eightKey = null;
					canClick = true;
					eightActive = false;
				} else if (nineActive) {
					Keys.slots[8] = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var nineKey:TextField = mainMenu.getChildByName("nineKey") as TextField;
					nineKey.text = Keys.KeyToChar[Keys.slots[8]];
					nineKey = null;
					canClick = true;
					nineActive = false;
				} else if (bagActive) {
					Keys.BAG = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var bagKey:TextField = mainMenu.getChildByName("bagKey") as TextField;
					bagKey.text = Keys.KeyToChar[Keys.BAG];
					bagKey = null;
					canClick = true;
					bagActive = false;
				} else if (rollActive) {
					Keys.ROLL = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var rollKey:TextField = mainMenu.getChildByName("rollKey") as TextField;
					rollKey.text = Keys.KeyToChar[Keys.ROLL];
					rollKey = null;
					canClick = true;
					rollActive = false;
				} else if (pauseActive) {
					Keys.PAUSE = keyGetter.GetKey();
					mainMenu.removeChild(keyGetter);
					var pauseKey:TextField = mainMenu.getChildByName("pauseKey") as TextField;
					pauseKey.text = Keys.KeyToChar[Keys.PAUSE];
					pauseKey = null;
					canClick = true;
					pauseActive = false;
				}
				
				keyGetter.Reset();
			}
		}
		
		private function CleanAndGoMain(e:MouseEvent) {
			(mainMenu.getChildByName("soundSlider") as Slider).Deactivate();
			(mainMenu.getChildByName("musicSlider") as Slider).Deactivate();
			mainMenu.getChildByName("pooButton").removeEventListener(MouseEvent.CLICK, PooQuality);
			mainMenu.getChildByName("diamondButton").removeEventListener(MouseEvent.CLICK, DiamondQuality);
			mainMenu.getChildByName("keyBindings").removeEventListener(MouseEvent.CLICK, KeyBinding);
			mainMenu.getChildByName("lightFlickerOn").removeEventListener(MouseEvent.CLICK, FlickerOn);
			mainMenu.getChildByName("lightFlickerOff").removeEventListener(MouseEvent.CLICK, FlickerOff);
			mainMenu.backButton.removeEventListener(MouseEvent.CLICK, CleanAndGoMain);
			ShowMain(e);
		}
		
		private function CleanAndGoKeys(e:MouseEvent) {
			(mainMenu.getChildByName("soundSlider") as Slider).Deactivate();
			(mainMenu.getChildByName("musicSlider") as Slider).Deactivate();
			mainMenu.getChildByName("pooButton").removeEventListener(MouseEvent.CLICK, PooQuality);
			mainMenu.getChildByName("diamondButton").removeEventListener(MouseEvent.CLICK, DiamondQuality);
			mainMenu.getChildByName("keyBindings").removeEventListener(MouseEvent.CLICK, KeyBinding);
			mainMenu.getChildByName("lightFlickerOn").removeEventListener(MouseEvent.CLICK, FlickerOn);
			mainMenu.getChildByName("lightFlickerOff").removeEventListener(MouseEvent.CLICK, FlickerOff);
			mainMenu.backButton.removeEventListener(MouseEvent.CLICK, CleanAndGoMain);
			KeyBinding(e);
		}
		
		private function CleanAndGoOptions(e:MouseEvent) {
			mainMenu.upButton.removeEventListener(MouseEvent.CLICK, UpClick);
			mainMenu.downButton.removeEventListener(MouseEvent.CLICK, DownClick);
			mainMenu.leftButton.removeEventListener(MouseEvent.CLICK, LeftClick);
			mainMenu.rightButton.removeEventListener(MouseEvent.CLICK, RightClick );
			mainMenu.useButton.removeEventListener(MouseEvent.CLICK, UseClick );
			mainMenu.sprintButton.removeEventListener(MouseEvent.CLICK, SprintClick);
			mainMenu.slot1.removeEventListener(MouseEvent.CLICK, OneClick);
			mainMenu.slot2.removeEventListener(MouseEvent.CLICK, TwoClick);
			mainMenu.slot3.removeEventListener(MouseEvent.CLICK, ThreeClick);
			mainMenu.slot4.removeEventListener(MouseEvent.CLICK, FourClick);
			mainMenu.slot5.removeEventListener(MouseEvent.CLICK, FiveClick);
			mainMenu.slot6.removeEventListener(MouseEvent.CLICK, SixClick);
			mainMenu.slot7.removeEventListener(MouseEvent.CLICK, SevenClick);
			mainMenu.slot8.removeEventListener(MouseEvent.CLICK, EightClick);
			mainMenu.slot9.removeEventListener(MouseEvent.CLICK, NineClick);
			
			mainMenu.bagButton.removeEventListener(MouseEvent.CLICK, BagClick);
			mainMenu.rollButton.removeEventListener(MouseEvent.CLICK, RollClick);
			mainMenu.pauseButton.removeEventListener(MouseEvent.CLICK, PauseClick);
			
			ShowOptions(e);
		}
		
		private function KeyBinding(e:MouseEvent):void {
			mainMenu.gotoAndStop("Keybindings");
			
			mainMenu.backButton1.addEventListener(MouseEvent.CLICK, CleanAndGoOptions);
			
			var upKey:TextField = mainMenu.getChildByName("upKey") as TextField;
			var downKey:TextField = mainMenu.getChildByName("downKey") as TextField;
			var leftKey:TextField = mainMenu.getChildByName("leftKey") as TextField;
			var rightKey:TextField = mainMenu.getChildByName("rightKey") as TextField;
			var useKey:TextField = mainMenu.getChildByName("useKey") as TextField;
			var sprintKey:TextField = mainMenu.getChildByName("sprintKey") as TextField;
			var oneKey:TextField = mainMenu.getChildByName("oneKey") as TextField;
			var twoKey:TextField = mainMenu.getChildByName("twoKey") as TextField;
			var threeKey:TextField = mainMenu.getChildByName("threeKey") as TextField;
			var fourKey:TextField = mainMenu.getChildByName("fourKey") as TextField;
			var fiveKey:TextField = mainMenu.getChildByName("fiveKey") as TextField;
			var sixKey:TextField = mainMenu.getChildByName("sixKey") as TextField;
			var sevenKey:TextField = mainMenu.getChildByName("sevenKey") as TextField;
			var eightKey:TextField = mainMenu.getChildByName("eightKey") as TextField;
			var nineKey:TextField = mainMenu.getChildByName("nineKey") as TextField;
			var rollKey:TextField = mainMenu.getChildByName("rollKey") as TextField;
			var bagKey:TextField = mainMenu.getChildByName("bagKey") as TextField;
			var pauseKey:TextField = mainMenu.getChildByName("pauseKey") as TextField;
			
			upKey.text = Keys.KeyToChar[Keys.UP];
			downKey.text = Keys.KeyToChar[Keys.DOWN];
			leftKey.text = Keys.KeyToChar[Keys.LEFT];
			rightKey.text = Keys.KeyToChar[Keys.RIGHT];
			useKey.text = Keys.KeyToChar[Keys.USE];
			sprintKey.text = Keys.KeyToChar[Keys.SPRINT];
			oneKey.text = Keys.KeyToChar[Keys.slots[0]];
			twoKey.text = Keys.KeyToChar[Keys.slots[1]];
			threeKey.text = Keys.KeyToChar[Keys.slots[2]];
			fourKey.text = Keys.KeyToChar[Keys.slots[3]];
			fiveKey.text = Keys.KeyToChar[Keys.slots[4]];
			sixKey.text = Keys.KeyToChar[Keys.slots[5]];
			sevenKey.text = Keys.KeyToChar[Keys.slots[6]];
			eightKey.text = Keys.KeyToChar[Keys.slots[7]];
			nineKey.text = Keys.KeyToChar[Keys.slots[8]];
			rollKey.text = Keys.KeyToChar[Keys.ROLL];
			bagKey.text = Keys.KeyToChar[Keys.BAG];
			pauseKey.text = Keys.KeyToChar[Keys.PAUSE];
			
			upKey = null;
			downKey = null;
			leftKey = null;
			rightKey = null;
			useKey = null;
			sprintKey = null;
			oneKey = null;
			twoKey = null;
			threeKey = null;
			fourKey = null;
			fiveKey = null;
			sixKey = null;
			sevenKey = null;
			eightKey = null;
			nineKey = null;
			rollKey = null;
			bagKey = null;
			pauseKey = null;
			
			mainMenu.upButton.addEventListener(MouseEvent.CLICK, UpClick);
			
			mainMenu.downButton.addEventListener(MouseEvent.CLICK, DownClick);
			
			mainMenu.leftButton.addEventListener(MouseEvent.CLICK, LeftClick);
			
			mainMenu.rightButton.addEventListener(MouseEvent.CLICK, RightClick );
			
			mainMenu.useButton.addEventListener(MouseEvent.CLICK, UseClick );
			
			mainMenu.sprintButton.addEventListener(MouseEvent.CLICK, SprintClick);
			
			mainMenu.bagButton.addEventListener(MouseEvent.CLICK, BagClick);
			mainMenu.rollButton.addEventListener(MouseEvent.CLICK, RollClick);
			mainMenu.pauseButton.addEventListener(MouseEvent.CLICK, PauseClick);
			
			mainMenu.slot1.addEventListener(MouseEvent.CLICK, OneClick);
			mainMenu.slot2.addEventListener(MouseEvent.CLICK, TwoClick);
			mainMenu.slot3.addEventListener(MouseEvent.CLICK, ThreeClick);
			mainMenu.slot4.addEventListener(MouseEvent.CLICK, FourClick);
			mainMenu.slot5.addEventListener(MouseEvent.CLICK, FiveClick);
			mainMenu.slot6.addEventListener(MouseEvent.CLICK, SixClick);
			mainMenu.slot7.addEventListener(MouseEvent.CLICK, SevenClick);
			mainMenu.slot8.addEventListener(MouseEvent.CLICK, EightClick);
			mainMenu.slot9.addEventListener(MouseEvent.CLICK, NineClick);
		}
		
		private function PooQuality(e:MouseEvent):void {
			main.stage.quality = StageQuality.MEDIUM;
		}
		
		private function DiamondQuality(e:MouseEvent):void {
			main.stage.quality = StageQuality.BEST;
		}
		
		private function BagClick(e:MouseEvent) {
			if(canClick){
				mainMenu.addChild(keyGetter);
				bagActive = true;
				canClick = false;
			}
		}
		private function RollClick(e:MouseEvent) {
			if(canClick){
				mainMenu.addChild(keyGetter);
				rollActive = true;
				canClick = false;
			}
		}
		private function PauseClick(e:MouseEvent) {
			if(canClick){
				mainMenu.addChild(keyGetter);
				pauseActive = true;
				canClick = false;
			}
		}
		
		private function UpClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				upActive = true;
				canClick = false;
			}
		}
		
		private function DownClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				downActive = true;
				canClick = false;
			}
		}
		private function LeftClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				leftActive = true;
				canClick = false;
			}
		}
		private function RightClick (e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				rightActive = true;
				canClick = false;
			}
		}
		private function UseClick (e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				useActive = true;
				canClick = false;
			}
		}
		private function SprintClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				sprintActive = true;
				canClick = false;
			}
		}
		
		private function OneClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				oneActive = true;
				canClick = false;
			}
		}
		private function TwoClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				twoActive = true;
				canClick = false;
			}
		}
		private function ThreeClick (e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				threeActive = true;
				canClick = false;
			}
		}
		private function FourClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				fourActive = true;
				canClick = false;
			}
		}
		private function FiveClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				fiveActive = true;
				canClick = false;
			}
		}
		private function SixClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				sixActive = true;
				canClick = false;
			}
		}
		private function SevenClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				sevenActive = true;
				canClick = false;
			}
		}
		private function EightClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				eightActive = true;
				canClick = false;
			}
		}
		private function NineClick(e:MouseEvent):void {
			if(canClick){
				mainMenu.addChild(keyGetter);
				nineActive = true;
				canClick = false;
			}
		}
		
		private function ShowMain(e:MouseEvent):void {
			mainMenu.gotoAndStop("menu");
		}
		
	}
}