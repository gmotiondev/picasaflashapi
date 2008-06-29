package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	import sk.prasa.webapis.picasa.objects.feed.Meta;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class UserMeta extends Meta implements IMeta 
	{
		public function UserMeta(xmllist : XMLList)
		{
			super(xmllist);
		}
		
		//dopisat metody typicke pre UserMeta
	}
}
