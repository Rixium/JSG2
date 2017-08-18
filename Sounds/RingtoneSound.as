package Sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class RingtoneSound extends Sound 
	{
		
		public function RingtoneSound(stream:URLRequest=null, context:SoundLoaderContext=null) 
		{
			super(stream, context);
			
		}
		
	}

}