package sk.prasa.tumblr.model 
{
	import sk.prasa.tools.model.SimpleContentProxy;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ContentProxy extends SimpleContentProxy 
	{
		public static const NAME : String = "ContentProxy";
		
		public function ContentProxy(data : Object = null)
		{
			super(NAME, data);
		}
	}
}
