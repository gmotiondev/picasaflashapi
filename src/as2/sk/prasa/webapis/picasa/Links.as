import sk.prasa.webapis.picasa.Link;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Links extends Array 
{
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
}
