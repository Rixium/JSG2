package Screens 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Rixium
	 */
	public class PauseScreen extends MovieClip
	{
		
		public function PauseScreen() 
		{
			x = GameManager.main.stage.stageWidth / 2;
			y = GameManager.main.stage.stageHeight / 2;
		}
		
		private function TickSP(e:Event) {
			if (GameManager.soundLevel + 0.01 <= 1) {
				GameManager.soundLevel += 0.01;
			} else {
				GameManager.soundLevel = 1;
			}
			soundLevel.text = Math.round(GameManager.soundLevel * 100).toString();
		}
		private function TickSM(e:Event) {
			if (GameManager.soundLevel - 0.01 >= 0) {
				GameManager.soundLevel -= 0.01;
			} else {
				GameManager.soundLevel = 0;
			}
			soundLevel.text = Math.round(GameManager.soundLevel * 100).toString();
		}
		
		private function TickMP(e:Event) {
			if (GameManager.musicLevel + 0.01 <= 1) {
				GameManager.musicLevel += 0.01;
			} else {
				GameManager.musicLevel = 1;
			}
			musicLevel.text = Math.round(GameManager.musicLevel * 100).toString();
			GameManager.gameScreen.musicManager.FadeTo();
		}
		private function TickMM(e:Event) {
			if (GameManager.musicLevel - 0.01 >= 0) {
				GameManager.musicLevel -= 0.01;
			} else {
				GameManager.musicLevel = 0;
			}
			musicLevel.text = Math.round(GameManager.musicLevel * 100).toString();
			GameManager.gameScreen.musicManager.FadeTo();
		}
		
		private function OutSP(e:Event) {
			removeEventListener(Event.ENTER_FRAME, TickSP);
			soundPlus.removeEventListener(MouseEvent.MOUSE_UP, OutSP);
		}
		private function OutSM(e:Event) {
			removeEventListener(Event.ENTER_FRAME, TickSM);
			soundMinus.removeEventListener(MouseEvent.MOUSE_UP, OutSM);
		}
		private function OutMM(e:Event) {
			removeEventListener(Event.ENTER_FRAME, TickMM);
			musicMinus.removeEventListener(MouseEvent.MOUSE_UP, OutMM);
		}
		private function OutMP(e:Event) {
			removeEventListener(Event.ENTER_FRAME, TickMP);
			musicPlus.removeEventListener(MouseEvent.MOUSE_UP, OutMP);
		}
		
		public function Added() {
			musicLevel.text = Math.round(GameManager.musicLevel * 100).toString();
			soundLevel.text = Math.round(GameManager.soundLevel * 100).toString();
			soundPlus.addEventListener(MouseEvent.MOUSE_DOWN, SoundPlus);
			soundMinus.addEventListener(MouseEvent.MOUSE_DOWN, SoundMinus);
			musicPlus.addEventListener(MouseEvent.MOUSE_DOWN, MusicPlus);
			musicMinus.addEventListener(MouseEvent.MOUSE_DOWN, MusicMinus);
		}
		
		private function SoundPlus(e:MouseEvent) {
			soundPlus.addEventListener(MouseEvent.MOUSE_UP, OutSP);
			addEventListener(Event.ENTER_FRAME, TickSP);
		}
		
		
		private function SoundMinus(e:MouseEvent) {
			soundMinus.addEventListener(MouseEvent.MOUSE_UP, OutSM);
			addEventListener(Event.ENTER_FRAME, TickSM);
		}
		
		private function MusicPlus(e:MouseEvent) {
			musicPlus.addEventListener(MouseEvent.MOUSE_UP, OutMP);
			addEventListener(Event.ENTER_FRAME, TickMP);
		}
		
		private function MusicMinus(e:MouseEvent) {
			musicMinus.addEventListener(MouseEvent.MOUSE_UP, OutMM);
			addEventListener(Event.ENTER_FRAME, TickMM);
		}
		
		public function Removed() {
			soundPlus.removeEventListener(MouseEvent.MOUSE_DOWN, SoundPlus);
			soundMinus.removeEventListener(MouseEvent.MOUSE_DOWN, SoundMinus);
			musicPlus.removeEventListener(MouseEvent.MOUSE_DOWN, MusicPlus);
			musicMinus.removeEventListener(MouseEvent.MOUSE_DOWN, MusicMinus);
			removeEventListener(Event.ENTER_FRAME, TickMP);
			musicPlus.removeEventListener(MouseEvent.MOUSE_UP, OutMP);
			removeEventListener(Event.ENTER_FRAME, TickMM);
			musicMinus.removeEventListener(MouseEvent.MOUSE_UP, OutMM);
			removeEventListener(Event.ENTER_FRAME, TickSM);
			soundMinus.removeEventListener(MouseEvent.MOUSE_UP, OutSM);
			removeEventListener(Event.ENTER_FRAME, TickSP);
			soundPlus.removeEventListener(MouseEvent.MOUSE_UP, OutSP);
			GameManager.main.stage.focus = GameManager.gameScreen.roomLayer;
		}
	}

}