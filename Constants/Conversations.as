package Constants 
{
	
	import Chat.ChatLine;
	import Chat.Conversation;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Conversations 
	{
		
		private static var conversation1Chat:Array = new Array( 
		new ChatLine(ChatHeads.MARKIPLIER, "Sean? Are you there?!"),
		new ChatLine(ChatHeads.SEAN, "What's going on? I'm freakin' out here, Mark."),
		new ChatLine(ChatHeads.MARKIPLIER, "Something is happening in the city. People are panicking. I thought you may be in danger."),
		new ChatLine(ChatHeads.SEAN, "I'm fine. What's going on?"),
		new ChatLine(ChatHeads.MARKIPLIER, "I'm not sure yet. I'm going to check it out. I'll call you back soon. Be safe."))
		
		private static var conversation2Chat:Array = new Array( 
		new ChatLine(ChatHeads.MARKIPLIER, "Sean. I have something to tell you."),
		new ChatLine(ChatHeads.SEAN, "What?"),
		new ChatLine(ChatHeads.MARKIPLIER, "I had a dream last night. We were in a dark room, and there were things trying to kill us."),
		new ChatLine(ChatHeads.SEAN, "That wasn't a dream. I was there!"),
		new ChatLine(ChatHeads.MARKIPLIER, "This is all too much for me, Sean."))
		
		public static var conversation1:Conversation = new Conversation(conversation1Chat);
		public static var conversation2:Conversation = new Conversation(conversation2Chat);
		
	}

}