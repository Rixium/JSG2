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
		
		private static var conversation3Chat:Array = new Array( 
		new ChatLine(ChatHeads.MARKIPLIER, "I have a bad feeling about this place."),
		new ChatLine(ChatHeads.SEAN, "How do you know where I am?"),
		new ChatLine(ChatHeads.MARKIPLIER, "Nevermind that. You know I don't like basements."),
		new ChatLine(ChatHeads.SEAN, "There might be some epic loot down here.."),
		new ChatLine(ChatHeads.MARKIPLIER, "Fine, just ignore me."))
		
		private static var septicSwordChat:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "..."),
		new ChatLine(ChatHeads.MARKIPLIER, "Nice sword.."))
		
		private static var atticChat:Array = new Array(
		new ChatLine(ChatHeads.HAPPYMA, "Sean?"),
		new ChatLine(ChatHeads.HAPPYMA, "My Sean?"),
		new ChatLine(ChatHeads.SEAN, "Ma?"),
		new ChatLine(ChatHeads.HAPPYMA, "I'm... so sorry, my son."),
		new ChatLine(ChatHeads.HAPPYMA, "I can't control it.."),
		new ChatLine(ChatHeads.SEAN, "Control what? Ma?"),
		new ChatLine(ChatHeads.ANGRYMA, "You.. Must.. Die."));
		
		public static var conversation1:Conversation = new Conversation(conversation1Chat);
		public static var conversation2:Conversation = new Conversation(conversation2Chat);
		public static var conversation3:Conversation = new Conversation(conversation3Chat);
		public static var septicSwordConvo:Conversation = new Conversation(septicSwordChat);
		public static var atticConvo:Conversation = new Conversation(atticChat);
		
	}

}