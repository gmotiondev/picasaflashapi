import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class sk.prasa.webapis.picasa.User extends Base
{
	// TODO:
	//public var opensearch : OpenSearch;
	public var gphoto : GPhoto;
	
	public function User(o : Object)
	{
		super(o);
		
		gphoto = new GPhoto(o, KindType.USER);
	}
		
	public function toString() : String
	{
		return "[User " + super.toString() + ", gphoto=" + gphoto.toString() + "]";
	}
}
