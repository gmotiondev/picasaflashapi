package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class MediaContent 
	{
		public var url : String;
		public var type : String;
		public var medium : String;
		public var height : Number;
		public var width : Number;
		public var fileSize : Number;
		
		public function MediaContent(u : String = null, t : String = null, m : String = null, h : Number = 0, w : Number = 0, s : Number = 0)
		{
			url = u;
			type = t;
			medium = m;
			height = h;
			width = w;
			fileSize = s;
		}
		
		public function toString() : String
		{
			return "[MediaContent " +
				"url=" + url + 
				", type=" + type + 
				", medium=" + medium + 
				", height=" + height + 
				", width=" + width + 
				", fileSize=" + fileSize + 
				"]";	
		}
	}
}
