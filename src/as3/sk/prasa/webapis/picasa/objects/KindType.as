package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class KindType 
	{
		public static const USER : String 		= "user";
		public static const ALBUM : String		= "album";
		public static const PHOTO : String		= "photo";
		public static const COMMENT : String	= "comment";
		public static const TAG : String 		= "tag";
		
		public static function getKindType(aType : String) : String
		{
			switch(aType)
			{
				case KindType.USER: 	return KindType.USER;
				case KindType.ALBUM: 	return KindType.ALBUM;
				case KindType.PHOTO: 	return KindType.PHOTO;
				case KindType.COMMENT: 	return KindType.COMMENT;
				case KindType.TAG: 		return KindType.TAG;
			}
			
			return null;
		}		
	}
}
