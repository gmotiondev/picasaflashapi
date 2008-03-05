/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.KindType extends String
{
	public static var USER : KindType 	= new KindType("user");
	public static var ALBUM : KindType 	= new KindType("album");
	public static var PHOTO : KindType 	= new KindType("photo");
	public static var COMMENT : KindType= new KindType("comment");
	public static var TAG : KindType 	= new KindType("tag");
	
	public function KindType(type : String)
	{
		super(type);
	}
}