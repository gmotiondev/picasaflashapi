/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.generic.PicasaServiceBase;
import com.bourre.data.libs.XMLToObject;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.PicasaService extends PicasaServiceBase
{
	public static var END_POINT:String = "http://www.prasa.sk/proxy.php?gws_path=http://picasaweb.google.com/data/feed/api/user/";
	public static var AUTH_END_POINT:String = "http://picasaweb.google.com/data/feed/api/user/";
	
	private var __api_key:String;
	
	private var __access:String;
	private var __thumbsize:Number
	private var __imgmax:Number;
	private var __max_results:Number;
	private var __start_index:Number;
	
	private var __auth:Auth;
	private var __albums:Albums;
	private var __photos:Photos;
	private var __tags:Tags;
	private var __comments:Comments;
	private var __community:Community
	
	public function PicasaService(API_KEY:String)
	{
		//super(this);

		__api_key = API_KEY;
		
		__auth = new Auth(this);
		__photos = new Photos(this);
		__albums = new Albums(this);
		__tags = new Tags(this);
		__comments = new Comments(this);
		__community = new Community(this);
		
		
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
	
	public function get comments():Comments
	{
		return __comments;
	}
	
	public function get community():Community
	{
		return __community;
	}
	
	public function get access():String
	{
		return __access;
	}
	
	public function set access(v:String):Void
	{
		__access = v;
	}
	
	public function get thumbsize():Number
	{
		return __thumbsize;
	}
	
	public function set thumbsize(v:Number):Void
	{
		__thumbsize = v;
	}
	
	public function get imgmax():Number
	{
		return __imgmax;
	}
	
	public function set imgmax(v:Number):Void
	{
		__imgmax = v;
	}
	
	public function get max_results():Number
	{
		return __max_results;
	}
	
	public function set max_results(v:Number)
	{
		__max_results = v;
	}
	
	public function get start_index():Number
	{
		return __start_index;
	}
	
	public function set start_index(v:Number):Void
	{
		__start_index = v;
	}
	
	public function get xmlLoader():XMLToObject
	{
		return getXMLService();
	}
}