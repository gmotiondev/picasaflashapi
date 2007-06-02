import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectDeserializer;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron
 * 
 *	 <channel>
		<item>
			<guid isPermaLink="false">http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5046158866819398449</guid> 
			<pubDate>Mon, 26 Mar 2007 07:00:00 +0000</pubDate> 
			<atom:updated>2007-03-26T09:17:05.000Z</atom:updated> 
			<category domain="http://schemas.google.com/g/2005#kind">http://schemas.google.com/photos/2007#album</category> 
			<title>Unsorted Lomo</title> 
			<description>Unsorted lomos</description> 
			<link>http://picasaweb.google.com/thisispinkfu/UnsortedLomo</link> 
			<author>Pink-fu</author> 
			<gphoto:id>5046158866819398449</gphoto:id> 
			<gphoto:name>UnsortedLomo</gphoto:name> 
			<gphoto:location>Various</gphoto:location> 
			<gphoto:access>public</gphoto:access> 
			<gphoto:timestamp>1174892400000</gphoto:timestamp> 
			<gphoto:numphotos>12</gphoto:numphotos> 
			<gphoto:user>thisispinkfu</gphoto:user> 
			<gphoto:nickname>Pink-fu</gphoto:nickname> 
			<gphoto:commentingEnabled>true</gphoto:commentingEnabled> 
			<gphoto:commentCount>0</gphoto:commentCount> 
			<media:group>
				<media:title type="plain">Unsorted Lomo</media:title> 
				<media:description type="plain">Unsorted lomos</media:description> 
				<media:keywords /> 
				<media:content url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg" type="image/jpeg" medium="image" /> 
				<media:thumbnail url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg?imgmax=160&crop=1" height="160" width="160" /> 
				<media:credit>Pink-fu</media:credit> 
			</media:group>
		</item>
 *	</channel>
 *  
 */

class Picasa.Service
{
	private static var __instance:Service;
	private var __data:XMLToObject;
	private var __xml:XML;

	/**
	 * 
	 */	
	public function Service(aParent:Object)
	{
		initialize();
	}
	/**
	 * Load xml from aUrl
	 */
	public function load(aUrl:String):Void
	{
		setFeed(aUrl);
	}
	
	private function initialize():Void
	{
		XMLToObjectDeserializer.DESERIALIZE_ATTRIBUTES = true;
		XMLToObjectDeserializer.ATTRIBUTE_TARGETED_PROPERTY_NAME = "attributes";
		XMLToObjectDeserializer.PUSHINARRAY_IDENTICAL_NODE_NAMES = true;
	}
	private function setFeed(aFeedURL:String):Void
	{
		__data = new XMLToObject(new Object());
		
		var tD = __data.getDeserializer();
			tD.addType("plain",tD,tD.getString);
			tD.addType("text",tD,tD.getString);
			tD.addType("image/jpeg",tD,tD.getObjectWithAttributes);
			tD.addType("application/atom+xml",tD,tD.getObjectWithAttributes);
		
		__data.addEventListener(XMLToObject.onLoadInitEVENT,this,onFileLoad);
		__data.addEventListener(XMLToObject.onLoadProgressEVENT,this,onFileProgress);
		__data.addEventListener(XMLToObject.onTimeOutEVENT,this,onFileTimeout);
		__data.addEventListener(XMLToObject.onErrorEVENT,this,onFileError);
		
		__data.load(aFeedURL);
	}
	/**
	 * 
	 */
	private function getData():XML
	{
		return __xml;
	}	
	/**
	 *  Override when extended
	 */
	private function onInitialize(e:IEvent):Void
	{
	}
	/**
	 * 
	 */
	private function onFileLoad(e:IEvent) : Void 
	{ 
		__xml = __data.getObject();
		onInitialize();
	}
	/**
	 * Override when extended.
	 */
	private function onFileProgress(e:IEvent):Void
	{
	}
	/**
	 * Override when extended.
	 */
	private function onFileTimeout(e:IEvent):Void
	{
	}
	/**
	 * Override when extended.
	 */
	private function onFileError(e:IEvent):Void
	{
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}