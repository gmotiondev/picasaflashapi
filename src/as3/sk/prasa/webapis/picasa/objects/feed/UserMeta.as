package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.feed.Meta;
	import sk.prasa.webapis.picasa.objects.feed.IMeta;
	
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
