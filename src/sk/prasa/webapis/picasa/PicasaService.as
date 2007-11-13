/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.generic.PicasaServiceBase;
import com.bourre.data.libs.XMLToObject;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.PicasaService extends PicasaServiceBase
{
	public static var END_POINT:String = "http://picasaweb.google.com/data/feed/api/user/";
	public static var AUTH_END_POINT:String = "http://picasaweb.google.com/data/feed/api/user/";
	
	private var __api_key:String;
	
	private var __auth:Auth;
	private var __people:People;
	private var __albums:Albums;
	private var __photos:Photos;
	private var __tags:Tags;
	
	public function PicasaService(API_KEY:String)
	{
		__api_key = API_KEY;
		
		__auth = new Auth(this);
		__people = new People(this);
		__photos = new Photos(this);
		__albums = new Albums(this);
		__tags = new Tags(this);
	}
	
	public function get api_key():String
	{
		return __api_key;
	}
	
	public function set api_key(value:String):Void
	{
		__api_key = value;
	}
	
	public function get auth():Auth
	{
		return __auth;
	}
	
	public function get people():People
	{
		return __people;
	}
	
	public function get photos():Photos
	{
		return __photos;
	}
	
	public function get albums():Albums
	{
		return __albums;
	}
	
	public function get tags():Tags
	{
		return __tags;
	}
	
	public function get xmlLoader():XMLToObject
	{
		return getXMLService();
	}
}