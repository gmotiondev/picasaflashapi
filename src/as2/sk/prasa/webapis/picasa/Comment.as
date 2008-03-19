import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Comment extends Base
{
	public var published : String;
	public var summary : String;
	public var content : String;
	public var gphoto : GPhoto;
	
	public function Comment(o:Object)
	{
		super(o);
		
		published = o.published;
		summary = o.summary;
		content = o.content;
		gphoto = new GPhoto(o, KindType.COMMENT);
	}
	
	public function toString() : String
	{
		return "[Comment " + super.toString() + ", published=" + published + ", summary=" + summary + ", content=" + content + ", gphoto=" + gphoto.toString() + "]";
	}
}
