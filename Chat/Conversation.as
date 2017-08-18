package Chat 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Conversation extends MovieClip 
	{
		
		private var chatLines:Array = new Array();
		public var currentLine:int = 0;
		
		public function Conversation(chatLines:Array) 
		{
			super();
			this.chatLines = chatLines;
		}
		
		public function AddChat(chatLine:ChatLine) {
			chatLines.push(chatLine);
		}
		
		public function GetChat():Array {
			return chatLines;
		}

		
	}

}