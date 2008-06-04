package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.BasicEntry;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class Tag extends BasicEntry
	{
		public var gphoto : GPhoto;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function Tag(aItem : XML, aParent : XML = null)
		{
			super(aItem, aParent);
			
			gphoto = new GPhoto(aItem, KindType.TAG);
		}
		
		override public function toString() : String
		{
			return "[Tag " + super.toString() +
				", gphoto=" + gphoto.toString() +
				"]";
		}
	}
}

/*
<entry>
	<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/bratislava</id>
	<updated>1970-01-01T00:23:48.000Z</updated>
	<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#tag"/>
	<title type="text">bratislava</title>
	<summary type="text">bratislava</summary>
	<link rel="alternate" type="text/html" href="http://picasaweb.google.com/lh/searchbrowse?q=bratislava&amp;psc=G&amp;uname=thisispinkfu&amp;filter=0"/>
	<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/tag/bratislava"/>
	<author>
		<name>Pink-fu</name>
		<uri>http://picasaweb.google.com/thisispinkfu</uri>
	</author>
	<gphoto:weight>8</gphoto:weight>
</entry>

*/