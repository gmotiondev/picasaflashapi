package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	import sk.prasa.webapis.picasa.objects.feed.Meta;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class PhotoMeta extends Meta implements IMeta 
	{
		public function PhotoMeta(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre PhotoMeta
	}
}
