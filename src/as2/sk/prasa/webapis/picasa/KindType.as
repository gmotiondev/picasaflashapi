/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.KindType extends String
{
	public static var USER : String 	= "user";
	public static var ALBUM : String	= "album";
	public static var PHOTO : String	= "photo";
	public static var COMMENT : String	= "comment";
	public static var TAG : String 		= "tag";
	
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
	
	/*
	public static var USER : KindType 	= new KindType("user");
	public static var ALBUM : KindType 	= new KindType("album");
	public static var PHOTO : KindType 	= new KindType("photo");
	public static var COMMENT : KindType= new KindType("comment");
	public static var TAG : KindType 	= new KindType("tag");
	
	public function KindType(type : String)
	{
		super(type);
	}*/
}