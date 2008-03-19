import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.GPhoto;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Tag extends Base
{
	public var summary : String;
	public var gphoto : GPhoto;
	
	public function Tag(o : Object)
	{
		super(o);
		
		summary = o.summary;
		gphoto = new GPhoto(o, KindType.TAG);
	}
	
	public function toString() : String
	{
		return "[Tag " + super.toString() + ", summary=" + summary + ", gphoto=" + gphoto.toString() + "]";
	}
}
