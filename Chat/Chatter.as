package Chat 
{
	import Constants.Conversations;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Constants.Keys;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Chatter extends MovieClip 
	{
		
		var conversation:Conversation;
		protected var chatting:Boolean = false;
		var chatBox:ChatBox;
		var canClick:Boolean = true;
		
		public function Chatter() 
		{
			super();
			
		}
		
		public function InitiateConversation(c:Conversation) {
			this.conversation = c;
		}
		
		public function StartChat() {
			GameManager.sean.reading = true;
			var chatLine:ChatLine = conversation.GetChat()[conversation.currentLine] as ChatLine;
			chatBox = new ChatBox();
			chatBox.addEventListener(MouseEvent.CLICK, ContinueChatByMouse);
			GameManager.main.addChild(chatBox);
			chatBox.x = GameManager.main.stage.stageWidth / 2;
			chatBox.y = 10 + chatBox.height / 2;
			chatBox.SetChatLine(chatLine);
			if (conversation.GetChat().length - 1 > conversation.currentLine) {
				conversation.currentLine++;
				GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, ContinueChat);
			}
		}
		
		protected function ContinueChat(e:KeyboardEvent) {
			if (e.keyCode == Keys.ROLL) {
				if (chatBox.finished) {
					chatBox.SetChatLine(conversation.GetChat()[conversation.currentLine]);
					if (conversation.GetChat().length - 1 > conversation.currentLine) {
							conversation.currentLine++;
					} else {
						chatBox.SetEndLine("End Chat");
						GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, ContinueChat);
						chatBox.removeEventListener(MouseEvent.CLICK, ContinueChatByMouse);
						GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, EndChat);
						chatBox.addEventListener(MouseEvent.CLICK, EndChatByMouse);
					}
				} else {
					chatBox.Finish();
				}
			}
		}
		
		protected function ContinueChatByMouse(e:MouseEvent) {
			if (chatBox.finished) {
				chatBox.SetChatLine(conversation.GetChat()[conversation.currentLine]);
				 if (conversation.GetChat().length - 1 > conversation.currentLine){
					 conversation.currentLine++;
				} else {
					chatBox.SetEndLine("End Chat");
					GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, ContinueChat);
					chatBox.removeEventListener(MouseEvent.CLICK, ContinueChatByMouse);
					GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, EndChat);
					chatBox.addEventListener(MouseEvent.CLICK, EndChatByMouse);
				}
			} else {
				chatBox.Finish();
			}
		}
		
		protected function EndChat(e:KeyboardEvent) {
			if (e.keyCode == Keys.ROLL) {
				if (chatBox.finished) {
					chatBox.Kill();
					conversation = null;
					chatting = false;
					GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, ContinueChat);
					chatBox.removeEventListener(MouseEvent.CLICK, ContinueChatByMouse);
					GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, EndChat);
					chatBox.removeEventListener(MouseEvent.CLICK, EndChatByMouse);
					GameManager.main.removeChild(chatBox);
					GameManager.main.stage.focus = GameManager.gameScreen.GetRoom();
					GameManager.sean.reading = false;
				} else {
					chatBox.Finish();
				}
			}
		}
		
		protected function EndChatByMouse(e:MouseEvent) {
			if (chatBox.finished) {
				if (canClick) {
					chatBox.Kill();
					conversation = null;
					chatting = false;
					GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, ContinueChat);
					chatBox.removeEventListener(MouseEvent.CLICK, ContinueChatByMouse);
					GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, EndChat);
					chatBox.removeEventListener(MouseEvent.CLICK, EndChatByMouse);
					GameManager.main.removeChild(chatBox);
					GameManager.main.stage.focus = GameManager.gameScreen.GetRoom();
					GameManager.sean.reading = false;
				}
			} else {
				chatBox.Finish();
			}
		}
		
		public function GetChat():Conversation {
			return this.conversation;
		}
		
	}

}