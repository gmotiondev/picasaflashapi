package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Generator 
	{
		public var uri : String;
		public var version : String;
		public var value : String;
		
		public function Generator(aUri : String = null, aVersion : String = null, aValue : String = null)
		{
			uri = aUri;
			version = aVersion;
			value = aValue;
		}
	}
}
