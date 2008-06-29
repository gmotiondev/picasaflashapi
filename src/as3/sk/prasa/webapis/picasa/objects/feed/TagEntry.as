package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.feed.Entry;
	import sk.prasa.webapis.picasa.objects.feed.IEntry;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class TagEntry extends Entry implements IEntry 
	{
		public function TagEntry(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre TagEntry
		
		public function get gphoto() : GPhoto
		{
			var tGPhoto : GPhoto = new GPhoto(this.data, Kind.TAG);
			return tGPhoto;
		}
		
		public function set gphoto(aGPhoto : GPhoto) : void
		{
			// TODO: ...
		}
	}
}
