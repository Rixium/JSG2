package Chat 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Rixium
	 */
	public class AudioChatLine extends ChatLine
	{
		
		public function AudioChatLine(talker:int, chatLine:String, audio:Sound, charTime:int) 
		{
			super(talker, chatLine);
			this.talker = talker;
			this.chatLine = chatLine;
			this.audio = audio;
			this.characterTime = charTime;
		}
		
	}

}