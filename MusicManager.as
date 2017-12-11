package 
{
	import fl.transitions.Transition;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import Constants.GameManager;
	import Constants.RoomTracks;
	
	import Sounds.*;
	/**
	 * ...
	 * @author Rixium
	 */
	public class MusicManager 
	{
		
		public var soundChannel:SoundChannel;
		public var transform:SoundTransform;
		var playing:Boolean = false;
		var hasTrackToPlay:Boolean = false;
		var fadeOut:Boolean = false;
		var fadeIn:Boolean = false;
		var newSound:Sound;
		var currentPlaying:int;
		var changeAmount:Number = 0.04;
		var muted:Boolean = false;
		
		public function MusicManager() 
		{
			transform = new SoundTransform(0, 0);
		}
		
		public function FadeOut() {
			fadeOut = true;
			fadeIn = false;
		}
		
		public function FadeIn() {
			fadeIn = true;
			fadeOut = false;
		}
		
		public function FadeTo() {
			transform.volume = GameManager.musicLevel;
			soundChannel.soundTransform = transform;
		}
		
		public function Update() {
			if (fadeOut) {
				var newVol = transform.volume - changeAmount;
				if (newVol < 0 ){
					newVol = 0;
				}
				transform.volume = newVol;
				soundChannel.soundTransform = transform;
				if (transform.volume <= 0) {
					if (hasTrackToPlay) {
						fadeIn = true;
						fadeOut = false;
						soundChannel = newSound.play(0, 9999, transform);
					} else {
						soundChannel.stop();
						fadeOut = false;
						fadeIn = false;
					}
				}
				
			} else if (fadeIn) {
				newVol = transform.volume + changeAmount;
				if (newVol >= GameManager.musicLevel) {
					newVol = GameManager.musicLevel;
					fadeIn = false;
					newSound = null;
				}
				transform.volume = newVol;
				soundChannel.soundTransform = transform;
			}
		}
		
		public function Mute() {
			soundChannel.stop();
			muted = true;
		}
		
		public function UnMute() {
			transform.volume = GameManager.musicLevel;
			var sound:Sound = RoomTracks.GetMusic(currentPlaying);
			if(muted) {
				soundChannel = sound.play(0, 9999 , transform);
				muted = false;
			}
		}
		
		public function PlayTrack(track:int) {
			if(track != RoomTracks.NONE) {
				if (currentPlaying != track) {
					currentPlaying = track;
					var sound:Sound = RoomTracks.GetMusic(track);
					if (playing) {
						newSound = sound;
						FadeOut();
						hasTrackToPlay = true;
					} else {
						playing = true;
						soundChannel = sound.play(0, 9999 , transform);
						FadeIn();
					}
				}
			} else {
				hasTrackToPlay = false;
				FadeOut();
			}
		}
	}

}