package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Utils;	
	import sk.prasa.webapis.picasa.objects.Namespaces;
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.feed.Entry;
	import sk.prasa.webapis.picasa.objects.feed.IEntry;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class CommentEntry extends Entry implements IEntry 
	{
		public var user : GPhoto;
		//BUG?: GPHOTO IS IN THE AUTHOR FEED
		
		private var gphotohack_ns : Namespace = Namespaces.GPHOTO_NS;
		
		public function CommentEntry(xmllist : XMLList)
		{
			super(xmllist);
			
			// GPHOTO HACK
			user = new GPhoto(new XMLList(), Kind.USER);
			user.user = Utils.parseString(this.data.author.gphotohack_ns::user);
			user.nickname = Utils.parseString(this.data.author.gphotohack_ns::nickname);
			user.thumbnail = Utils.parseString(this.data.author.gphotohack_ns::thumbnail);
		}
		
		//dopisat metody typicke pre CommentEntry
		
		public function get gphoto() : GPhoto
		{
			var tGPhoto : GPhoto = new GPhoto(this.data, Kind.COMMENT);
			return tGPhoto;
		}
		
		public function set gphoto(aGPhoto : GPhoto) : void
		{
			// TODO: ...
		}
	}
}
