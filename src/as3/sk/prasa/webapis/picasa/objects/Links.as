package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.Link;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	dynamic public class Links extends Array 
	{
		public function Links()
		{
		}
		
		public function getByRel(rel : String) : Link
		{
			for(var a : Number = 0; a < this.length; a++)
			{
				var tLink : Link = Link(this[a]);
				if(tLink.rel == rel) return tLink;
			}
			
			return null;
		}
		
		public function getByType(type : String) : Link
		{
			for(var a : Number = 0; a < this.length; a++)
			{
				var tLink : Link = Link(this[a]);
				if(tLink.type == type) return tLink;
			}
			
			return null;
		}
		
		public function toString() : String
		{
			var tRes : String = "[Links ";
			
			for(var a : Number = 0; a < this.length; a++)
			{
				var tLink : Link = Link(this[a]);
				tRes += tLink.toString() + "";
			}
			
			tRes += "]";
			
			return tRes;
		}
	}
}