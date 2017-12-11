package Chat 
{
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class ChatLine 
	{
		
		public var talker:int;
		public var chatLine:String;
		public var audio:Sound;
		public var characterTime:int = 0;
		
		public function ChatLine(talker:int, chatLine:String) 
		{
			this.talker = talker;
			this.chatLine = chatLine;
		}
		
	}

}