package sk.prasa.webapis.picasa.objects 
{
	import sk.prasa.webapis.picasa.objects.BasicFeed;
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * extends BasicFeed and implement custom properties from BasicEntry
	 */
	
	public class Album extends BasicFeed
	{
		/* implement also BasicFeed properties */
		public var content : Content;
		public var published : String;
		public var summary : String;
		
		/* and custom properties */
		public var gphoto : GPhoto;
		public var media : Media;
		public var geo : Geo;
		public var opensearch : OpenSearch;
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function Album(aItem : XML, aParent : XML = null)
		{	
			super(aItem, aParent);
			
			content = new Content(aItem.content.@type, aItem.content.@src);
			published = aItem.published;
			summary = aItem.summary;
			
			gphoto = new GPhoto(aItem, KindType.ALBUM);
			media = new Media(aItem);
			geo = new Geo(aItem);
			opensearch = new OpenSearch(aItem);
		}

		override public function toString() : String
		{
			return "[Album " + super.toString() +
				", content=" + content.toString() +
				", published=" + published + 
				", summary=" + summary +
				", gphoto=" + gphoto.toString() +
				", media=" + media.toString() +
				", geo=" + geo.toString() +
				", opensearch=" + opensearch.toString() +
				"]"; 
		}
	}
}

/*
	<entry>
		<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521</id>
		<published>2008-03-24T21:57:35.000Z</published>
		<updated>2008-01-30T19:35:50.000Z</updated>
		<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#album"/>
		<title type="text">Diana plus</title>
		<summary type="text"/>
		<rights type="text">public</rights>
		<link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521"/>
		<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/DianaPlus"/>
		<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521"/>
		<link rel="edit" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521/1201721750438574?tok=Oobe6Tyuu4WuggQLurl0MQPLSVE"/>
		<author>
			<name>Pink-fu</name>
			<uri>http://picasaweb.google.com/thisispinkfu</uri>
		</author>
		<gphoto:id>5161355527636525521</gphoto:id>
		<gphoto:name>DianaPlus</gphoto:name>
		<gphoto:location>Slovakia</gphoto:location>
		<gphoto:access>public</gphoto:access>
		<gphoto:timestamp>1206395855000</gphoto:timestamp>
		<gphoto:numphotos>6</gphoto:numphotos>
		<gphoto:numphotosremaining>494</gphoto:numphotosremaining>
		<gphoto:bytesUsed>480808</gphoto:bytesUsed>
		<gphoto:user>thisispinkfu</gphoto:user>
		<gphoto:nickname>Pink-fu</gphoto:nickname>
		<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
		<gphoto:commentCount>0</gphoto:commentCount>
		<media:group>
			<media:title type="plain">Diana plus</media:title>
			<media:description type="plain"/>
			<media:keywords/>
			<media:content url="http://lh3.google.com/thisispinkfu/R6DRgaBGIdE/AAAAAAAABR0/WzCg01fEF8k/DianaPlus.jpg" type="image/jpeg" medium="image"/>
			<media:thumbnail url="http://lh3.google.com/thisispinkfu/R6DRgaBGIdE/AAAAAAAABR0/WzCg01fEF8k/s160-c/DianaPlus.jpg" height="160" width="160"/>
			<media:credit>Pink-fu</media:credit>
		</media:group>
		<georss:where>
			<gml:Point>
				<gml:pos>48.669025999999995 19.699023999999998</gml:pos>
			</gml:Point>
		</georss:where>
	</entry>
*/