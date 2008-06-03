package sk.prasa.webapis.picasa.objects 
{	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.BasicFeed;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * feed kind "user" doesn't have a parent
	 */
	
	public class User extends BasicFeed
	{
		public var opensearch : OpenSearch;
		public var gphoto : GPhoto;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function User(item : XML)
		{
			super(item, null);
			
			opensearch = new OpenSearch(item);
			gphoto = new GPhoto(item, KindType.USER);
		}
		
		override public function toString() : String
		{
			return "[User " + super.toString() +
				", opensearch=" + opensearch.toString() +
				", gphoto=" + gphoto.toString() +
				"]";
		}
	}
}
