import sk.prasa.webapis.picasa.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Tag extends BasicEntry
{
	public var gphoto : GPhoto;
		
	public function Tag(aItem : Object, aParent : Object)
	{
		super(aItem, aParent);
		
		gphoto = new GPhoto(aItem, KindType.TAG);
	}
	
	public function toString() : String
	{
		return "[Tag " + super.toString() +
			", gphoto=" + gphoto.toString() +
			"]";
	}
	
	/*
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
	}*/
}
