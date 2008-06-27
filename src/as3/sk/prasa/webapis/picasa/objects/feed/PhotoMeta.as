package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Kind;	
	import sk.prasa.webapis.picasa.objects.feed.Meta;
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PhotoMeta extends Meta implements IMeta 
	{
		public function PhotoMeta(xmllist : XMLList)
		{
			super(xmllist);
			
			KIND = Kind.PHOTO;
		}
		
		//dopisat metody typicke pre PhotoMeta
	}
}
