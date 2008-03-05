import sk.prasa.webapis.picasa.Author;
import sk.prasa.webapis.picasa.Category;
import sk.prasa.webapis.picasa.Generator;
import sk.prasa.webapis.picasa.Link;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Base
{
	public var title : String;
	public var id : String;
	public var links : Array;
	public var subtitle : String;
	public var rights : String;
	public var author : Author;
	public var updated : String;
	public var category : Category;
	public var generator : Generator;
	public var icon : String;
	public var logo : String;
	
	public function Base(o : Object)
	{
		links = [];
		
		title = o.title;
		id = o.id;
		links = getLinks(o.link);
		subtitle = o.subtitle;
		rights = o.rights;
		
		author = new Author(o.author.name, o.author.email, o.author.uri);
		updated = o.updated;
		category = new Category(o.category.attributes.term, o.category.attributes.scheme);
		generator = new Generator(o.generator);
		icon = o.icon;
		logo = o.logo;
	}
	
	private function getLinks(o : Object) : Array
	{
		var tLinks:Array = [];
		
		for(var a:Number = 0; a < o.length; a++)
		{
			tLinks.push(new Link(o[a].attributes.href, o[a].attributes.type, o[a].attributes.rel));
		}
		
		return tLinks;
	}
}

/*
 <id>
http://picasaweb.google.com/data/feed/api/user/thisispinkfu
</id>
<updated>2007-11-13T23:11:34.980Z</updated>
<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#user"/>
<title type="text">thisispinkfu</title>
<subtitle type="text"/>
−
	<icon>
http://lh6.google.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu
</icon>
<link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu"/>
<link rel="http://schemas.google.com/g/2005#post" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu"/>
<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu"/>
<link rel="http://schemas.google.com/photos/2007#slideshow" type="application/x-shockwave-flash" href="http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%3Falt%3Drss"/>
<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu?start-index=1&max-results=1000"/>
−
	<author>
<name>Pink-fu</name>
<uri>http://picasaweb.google.com/thisispinkfu</uri>
</author>
<generator version="1.00" uri="http://picasaweb.google.com/">Picasaweb</generator>
<openSearch:totalResults>7</openSearch:totalResults>
<openSearch:startIndex>1</openSearch:startIndex>
<openSearch:itemsPerPage>1000</openSearch:itemsPerPage>
  */