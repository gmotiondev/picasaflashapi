package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Generator 
	{
		public var name : String;
		public var version : String;
		public var uri : String;
		
		public function Generator(n : String, v : String, u : String)
		{
			name = n;
			version = v;
			uri = u;
		}
		
		public function toString() : String
		{
			return "[Generator " +
				" name=" + name + 
				", version=" + version + 
				", uri=" + uri + 
				"]";
		}
	}
}
