/**
 *
 */
import sk.prasa.webapis.picasa.Author;
import sk.prasa.webapis.picasa.Category;
import sk.prasa.webapis.picasa.Generator;
import sk.prasa.webapis.picasa.Link;

class sk.prasa.webapis.picasa.Base
{
	private var __title:String;
	private var __id:String;
	private var __links:Array;
	private var __subtitle:String;
	private var __rights:String
	private var __author:Author;
	private var __updated:String;
	private var __category:Category;
	private var __generator:Generator;
	private var __icon:String;
	private var __logo:String;
	
	public function Base(o:Object)
	{
		__links = [];
		
		__title = o.title;
		__id = o.id;
		__links = getLinks(o.link);	
		__subtitle = o.subtitle;
		__rights = o.rights;
		__author = new Author(o.author.name, o.author.email, o.author.uri);
		__updated = o.updated;
		__category = new Category(o.category.attributes.term, o.category.attributes.scheme);
		__generator = new Generator(o.generator.data,o.generator.attributes.version,o.generator.attributes.uri);
		__icon = o.icon;
		__logo = o.logo;
	}
	
	// 
	public function get title():String
	{
		return __title;
	}
	
	// 
	public function set title(v:String)
	{
		__title = v;
	}
	
	// 
	public function get id():String
	{
		return __id;
	}
	// 
	public function set id(v:String):Void
	{
		__id = v;
	}

	public function get links():Array
	{
		return __links;
	}
	
	public function set links(a:Array):Void
	{
		__links = a;
	}
	
	// 
	public function get subtitle():String
	{
		return __subtitle;
	}
	
	// 
	public function set subtitle(v:String):Void
	{
		__subtitle = v;
	}
	
	// 
	public function get rights():String
	{
		return __rights;
	}
	
	// 
	public function set rights(v:String):Void
	{
		__rights = v;
	}
	
	// 
	public function get author():Author
	{
		return __author;
	}
	
	// 
	public function set author(v:Author):Void
	{
		__author = v;
	}
	
	public function get updated():String
	{
		return __updated;
	}
	
	public function set updated(v:String):Void
	{
		__updated = v;
	}
	
	// 
	public function get category():Category
	{
		return __category;
	}
	
	// 
	public function set category(v:Category):Void
	{
		__category = v;
	}
	
	//
	public function get generator():Generator
	{
		return __generator;
	}
	
	// 
	public function set generator(v:Generator):Void
	{
		__generator = v;
	}

	// 
	public function get icon():String
	{
		return __icon;
	}
	
	// 
	public function set icon(v:String)
	{
		__icon = v;
	}
	
	// 
	public function get logo():String
	{
		return __logo;
	}
	
	// 
	public function set logo(v:String)
	{
		__logo = v;
	}
	
	private function getLinks(o:Object):Array
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