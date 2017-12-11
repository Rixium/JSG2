package Constants 
{
	
	import Chat.AudioChatLine;
	import Chat.ChatLine;
	import Chat.Conversation;
	import Sounds.Sam.*;
	import Sounds.*;
	
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
		
		private static var maDeath:Array = new Array(
		new ChatLine(ChatHeads.ANGRYMA, "I'm sorry.."),
		new ChatLine(ChatHeads.ANGRYMA, "Go.. take this.."),
		new ChatLine(ChatHeads.ANGRYMA, "I've hidden the gate key in my room."),
		new ChatLine(ChatHeads.SEAN, "Ma?"),
		new ChatLine(ChatHeads.ANGRYMA, "I love you.."));
		
		
		private static var maDead:Array = new Array(
		new ChatLine(ChatHeads.SEAN, "NOOOO!"),
		new ChatLine(ChatHeads.SEAN, "MAAAAA!"));
		
		private static var masRoomChat1:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "I've just been outside."),
		new ChatLine(ChatHeads.SEAN, "What's going on?"),
		new ChatLine(ChatHeads.MARKIPLIER, "I can't believe it, Sean."),
		new ChatLine(ChatHeads.MARKIPLIER, "Look through the window, you'll see."));
		
		private static var masRoomChat2:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "You see?"),
		new ChatLine(ChatHeads.SEAN, "It's not possible!"),
		new ChatLine(ChatHeads.MARKIPLIER, "Sean, we have to end it."),
		new ChatLine(ChatHeads.SEAN, "There is no way."),
		new ChatLine(ChatHeads.MARKIPLIER, "Meet me at the City."));
		
		private static var cityViewChat:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "There are THINGS everywhere, Sean."),
		new ChatLine(ChatHeads.SEAN, "Nice Ride!"),
		new ChatLine(ChatHeads.MARKIPLIER, "It's not mine."),
		new ChatLine(ChatHeads.SEAN, "It really suits you."),
		new ChatLine(ChatHeads.MARKIPLIER, "Enough joking around.."),
		new ChatLine(ChatHeads.MARKIPLIER, "The world.."),
		new ChatLine(ChatHeads.MARKIPLIER, "..needs.."),
		new ChatLine(ChatHeads.MARKIPLIER, "..a HERO!"),
		new ChatLine(ChatHeads.MARKIPLIER, "Now, get in the back."),
		new ChatLine(ChatHeads.MARKIPLIER, "Grown ups in the front.."),
		new AudioChatLine(ChatHeads.MARKIPLIER, "Hahaha!", new MarkiplierLaugh(), 2));
		
		private static var cityStartChat1:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "Now, go my mighty Sean."),
		new ChatLine(ChatHeads.MARKIPLIER, "Go forth and..."),
		new ChatLine(ChatHeads.SEAN, "It's not possible."),
		new ChatLine(ChatHeads.MARKIPLIER, "I had a feeling you might have said that."),
		new ChatLine(ChatHeads.MARKIPLIER, "It's dangerous to go alone."),
		new ChatLine(ChatHeads.MARKIPLIER, "Take this."));
		
		private static var cityStartChat2:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "I would join you, but.."),
		new ChatLine(ChatHeads.MARKIPLIER, "I've misplaced my pants."),
		new ChatLine(ChatHeads.MARKIPLIER, "Stay safe."));
		
		private static var rooftopchat1:Array = new Array(
		new ChatLine(ChatHeads.SEAN, "Hello?"),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "Oh, Sean. How I pity you.", new Intro1(), 4),
		new ChatLine(ChatHeads.SEAN, "Who's there?"),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "You came to my world..", new Intro2(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "You laid waste to my corruption..", new Intro3(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "and now you come here, to save your own?", new Intro4(), 4),
		new ChatLine(ChatHeads.SEAN, "I'm not afraid of you."),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "Those you hold so close will perish under me.", new Intro5(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "Prepare yourself.", new Intro6(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "I..", new Intro7(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "WILL TEAR APART..", new Intro8(), 4),
		new AudioChatLine(ChatHeads.SAMUNKNOWN, "YOUR SOUL!", new Intro9(), 4));
		
		private static var markEndChat:Array = new Array(
		new ChatLine(ChatHeads.MARKIPLIER, "Sean!"),
		new ChatLine(ChatHeads.MARKIPLIER, "This thing is not just an eye."),
		new ChatLine(ChatHeads.MARKIPLIER, "It's a demon."),
		new ChatLine(ChatHeads.SEAN, "I don't understand."),
		new ChatLine(ChatHeads.MARKIPLIER, "According to old folk lore.. "),
		new ChatLine(ChatHeads.MARKIPLIER, "..there is only one true way to destroy a demon.."),
		new ChatLine(ChatHeads.MARKIPLIER, "..you must name the Demon."),
		new ChatLine(ChatHeads.SAM, "No!"),
		new ChatLine(ChatHeads.MARKIPLIER, "Do it, Sean, before it regenerates. Do it quick."));
		
		private static var endChat:Array = new Array(
		new ChatLine(ChatHeads.SEAN, "Demon!"),
		new ChatLine(ChatHeads.SAM, "No!"),
		new ChatLine(ChatHeads.SEAN, "I name you.."),
		new ChatLine(ChatHeads.SEAN, "SAM."));
		
		private static var endChat2:Array = new Array(
		new ChatLine(ChatHeads.SAM, "You cannot!"),
		new ChatLine(ChatHeads.SAM, "NO!"));

		
		public static var conversation1:Conversation = new Conversation(conversation1Chat);
		public static var conversation2:Conversation = new Conversation(conversation2Chat);
		public static var conversation3:Conversation = new Conversation(conversation3Chat);
		public static var septicSwordConvo:Conversation = new Conversation(septicSwordChat);
		public static var atticConvo:Conversation = new Conversation(atticChat);
		public static var maDeathConvo:Conversation = new Conversation(maDeath);
		public static var maDeadConvo:Conversation = new Conversation(maDead);
		
		public static var masRoomConvo1:Conversation = new Conversation(masRoomChat1);
		public static var masRoomConvo2:Conversation = new Conversation(masRoomChat2);
		
		public static var cityViewConvo:Conversation = new Conversation(cityViewChat);
		public static var cityStartConvo:Conversation = new Conversation(cityStartChat1);
		public static var cityStartConvo2:Conversation = new Conversation(cityStartChat2);
		
		public static var rooftopConvo1:Conversation = new Conversation(rooftopchat1);
		
		public static var MarkEndConvo:Conversation = new Conversation(markEndChat);
		public static var endConvo:Conversation = new Conversation(endChat);
		public static var endConvo2:Conversation = new Conversation(endChat2);
		
		public static function Reset() {
			conversation1.Reset();
			conversation2.Reset();
			conversation3.Reset();
			septicSwordConvo.Reset();
			atticConvo.Reset();
			maDeathConvo.Reset();
			maDeadConvo.Reset();
			
			masRoomConvo1.Reset();
			masRoomConvo2.Reset();
			
			cityViewConvo.Reset();
			cityStartConvo.Reset();
			cityStartConvo2.Reset();
			
			rooftopConvo1.Reset();
			
			MarkEndConvo.Reset();
			endConvo.Reset();
			endConvo2.Reset();
		}
		
	}

}