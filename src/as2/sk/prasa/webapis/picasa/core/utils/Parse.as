import sk.prasa.webapis.picasa.*;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.utils.Parse 
{
	public static function photos(o : Object) : Array
	{
		var tRes : Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tPhoto : Photo = new Photo(o.entry[a]);
					tPhoto.album = new Album(o);
					 
				tRes.push(tPhoto);
			}
		} else
		{
			// there are no photos?
			if(o.entry != undefined)
			{
				var tSinglePhoto : Photo = new Photo(o.entry);
					tSinglePhoto.album = new Album(o);
					 
				tRes.push(tSinglePhoto);
			}
		}
		
		// o should be a parsed xml to object
		return tRes;
	}
	
	public static function albums(o : Object) : Array
	{
		var tRes : Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tAlbum:Album = new Album(o.entry[a]);
					tAlbum.user = new User(o);
					
				tRes.push(tAlbum);
			}
		} else
		{
			// there are no albums?
			if(o.entry != undefined)
			{
				var tSingleAlbum:Album = new Album(o.entry);
					tSingleAlbum.user = new User(o);
				
				tRes.push(tSingleAlbum);
			}
		}
		
		// o should be a parsed xml to object
		return tRes;
	}
	
	public static function comments(o : Object) : Array
	{
		var tRes : Array = [];
		
		// there is more than one entry
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tComment : Comment = new Comment(o.entry[a]);
				
				tRes.push(tComment);
			}
		} else
		{
			// there are no comments?
			if(o.entry != undefined)
			{
				var tSingleComment:Comment = new Comment(o.entry);
				
				tRes.push(tSingleComment);
			}
		}
		
		return tRes;
	}
	
	public static function tags(o : Object):Array
	{
		var tRes : Array = [];
		
		// there is more than one tag
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tTag : Tag = new Tag(o.entry[a]);
				
				tRes.push(tTag);
			}
		} else
		{
			// there are no tags?
			if(o.entry != undefined)
			{
				var tSingleTag : Tag = new Tag(o.entry);
				
				tRes.push(tSingleTag);
			}
		}
		
		return tRes;
	}

	public static function community(o : Object) : Array
	{
		return Parse.photos(o);
	}
}
