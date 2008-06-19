package sk.prasa.webapis.picasa 
{
	import flash.system.Security;
	
	import sk.prasa.webapis.picasa.core.*;
	import sk.prasa.webapis.picasa.core.observer.UrlParamsObservable;
	import sk.prasa.webapis.picasa.objects.UrlParams;		

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	final public class PicasaService
	{
		public static var POLICY_FILE_URL : String = "http://photos.googleapis.com/data/crossdomain.xml";  
		public static var FEED_API_URL : String = "http://photos.googleapis.com/data/feed/api/";
		public static var FEED_BASE_URL : String = "http://photos.googleapis.com/data/feed/base/";
		
		private var __auth : Auth;
		private var __albums : Albums;
		private var __photos : Photos;
		private var __tags : Tags;
		private var __comments : Comments;
		private var __community : Community;
		private var __contacts : Contacts;
		
		private var __params : UrlParams;
		private var __paramsObservable : UrlParamsObservable;

		/**
		 * PicasaService Constructor
		 * 
		 * Constructing a PicasaService object and loading albums for given user:
		 * <listing>
		 * import sk.prasa.webapis.picasa.PicasaService;
		 * import sk.prasa.webapis.picasa.PicasaResponder;
		 * import sk.prasa.webapis.picasa.events.PicasaDataEvent;
		 * 
		 * var service : PicasaService = new PicasaService();
		 * 		service.imgmax = "320";
		 * 		service.thumbsize = "64c";
		 * 		service.max_results = 10;
		 * 		
		 * var responder : PicasaResponder = service.albums.list('username'); 
		 * 		responder.addEventListener(PicasaDataEvent.DATA, onComplete);
		 * 		responder.addEventListener(ErrorEvent.ERROR, onError);
		 * 		responder.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
		 * </listing>
		 */
		public function PicasaService()
		{
			Security.loadPolicyFile(PicasaService.POLICY_FILE_URL);

			__params = new UrlParams();
			__paramsObservable = new UrlParamsObservable();
			
			__auth = new Auth();
			__photos = new Photos();
			__albums = new Albums();
			__tags = new Tags();
			__comments = new Comments();
			__community = new Community();
			__contacts = new Contacts();
			
			__paramsObservable.subscribe(__auth.params);
			__paramsObservable.subscribe(__photos.params);
			__paramsObservable.subscribe(__albums.params);
			__paramsObservable.subscribe(__tags.params);
			__paramsObservable.subscribe(__comments.params);
			__paramsObservable.subscribe(__community.params);
			__paramsObservable.subscribe(__contacts.params);
		}
		
		/**
		 * <p>Visibility values let you request data at various levels of sharing. For example, a visibility value of <code>public</code> requests publicly visible data. 
		 * For a list of values, see Visibility values, below. If you don't specify a visibility value, then the visibility depends on your authentication. 
		 * For authenticated requests, the default is <code>all</code>. For unauthenticated requests, the default is <code>public</code>.</p>
		 * 
		 * <p>The URI of a representation of a Picasa Web Albums feed takes the following form:
		 * <code>http://picasaweb.google.com/data/feed/projection/path?kind=kind&access=visibility</code></p>
		 * 
		 * <p>The following table describes the supported visibility values:</p>
		 * <table>
		 * <tr><th>Visibility</th>	<th>Description</th>						<th>Security Notes</th></tr>
		 * <tr><td>all</td>			<td>Shows both public and private data.</td><td>Requires authentication. Default for authenticated users.</td></tr>
		 * <tr><td>private</td>		<td>Shows only private data.</td>			<td>Requires authentication.</td></tr>
		 * <tr><td>public</td>		<td>Shows only public data.</td>			<td>Does not require authentication. Default for unauthenticated users.</td></tr>
		 * </table>
		 * 
		 * @see http://code.google.com/apis/picasaweb/reference.html#Visibility
		 */
		public function get access() : String
		{
			return __params.access;
		}
		
		/**
		 * @private
		 */
		public function set access(value : String) : void
		{
			__params.access = value;
			
			sendParams();
		}
		
		/**
		 * Thumbnail size parameter
		 * 
		 * <p>Valid with <code>album</code> or <code>photo</code> kinds; specifies what image size to use for thumbnails. 
		 * <b>Multiple values</b> may be specified using a comma-delimited list. If multiple values are specified, 
		 * multiple <code>media:thumbnail</code> elements will be returned in the feed. 
		 * Refer to the list of valid values below.</p>
		 * 
		 * 
		 * <p>The following values are valid for the <code>thumbsize</code> and <code>imgmax</code> query parameters and are embeddable on a webpage. 
		 * These images are available as both cropped(<code>c</code>) and uncropped(<code>u</code>) sizes by appending <code>c</code> or <code>u</code> to the size. 
		 * As an example, to retrieve a 72 pixel image that is cropped, you would specify <code>72c</code>, while to retrieve the uncropped image, you would specify <code>72u</code> for the <code>thumbsize</code> or <code>imgmax</code> query parameter values.</p>
		 * 
		 * <p><code>32, 48, 64, 72, 144, 160</code></p>
		 * 
		 * <p>The following values are valid for the <code>thumbsize</code> and <code>imgmax</code> query parameters and are embeddable on a webpage. 
		 * These images are available as only uncropped(<code>u</code>) sizes by appending <code>u</code> to the size or just passing the size value without appending anything.</p>
		 * 
		 * <p><code>200, 288, 320, 400, 512, 576, 640, 720, 800</code></p>
		 *
		 * <p>The following values are valid for the <code>thumbsize</code> and <code>imgmax</code> query parameters and are <b>not</b> embeddable on a webpage. 
		 * These image sizes are only available in uncropped format and are accessed using only the size (no <code>u</code> is appended to the size).</p>
		 * 
		 * <p>912, 1024, 1152, 1280, 1440, 1600</p>
		 *  
		 * <p>There is an additional size <code>d</code> which results in the <code><media:content></code> elements referencing the original uploaded photo, including all original <code>Exif</code> data. It is valid only for use with the <code>imgmax</code> query parameter.</p>
		 * 
		 * <p>These query parameters are used when retrieving the feeds in order to get images of the appropriate sizes. They cannot be used when retrieving the actual images.</p>
		 *  
		 */
		public function get thumbsize() : String
		{
			return __params.thumbsize;
		}
		
		/**
		 * @private
		 */
		public function set thumbsize(value : String) : void
		{
			__params.thumbsize = value;
			
			sendParams();
		}
		
		/**
		 * <p>Image size parameter</p>
		 * 
		 * <p>Valid with <code>album</code> or <code>photo</code> kinds; specifies what image size to use for the <code>media:content</code>. 
		 * Only a <b>single value</b> may be specified. Refer to the list of valid values below.</p>
		 * 
		 * @see #thumbsize
		 */
		public function get imgmax() : String
		{
			return __params.imgmax;
		}
		
		/**
		 * @private
		 */
		public function set imgmax(value : String) : void
		{
			__params.imgmax = value;
			
			sendParams();
		}
		
		/**
		 * <p>Maximum number of results to be retrieved</p>
		 * 
		 * <p>For any service that has a default max-results value (to limit default feed size), you can specify a very large number if you want to receive the entire feed.
		 * See the Google Data query parameter reference below.</p>
		 * 
		 * @see http://code.google.com/apis/gdata/reference.html#Queries
		 */
		public function get max_results() : int
		{
			return __params.max_results;
		}
		
		/**
		 * @private
		 */
		public function set max_results(value : int) : void
		{
			__params.max_results = value;
			
			sendParams();
		}
		
		/**
		 * <p>1-based index of the first result to be retrieved</p>
		 * <p>Used to page through the result set. See the Google Data query parameter reference below.</p>
		 * 
		 * <p>Note that this isn't a general cursoring mechanism. If you first send a query with<br/> 
		 * <code>?start-index=1&max-results=10</code> and then send another query with </br>
		 * <code>?start-index=11&max-results=10</code>, the service cannot guarantee that the results are equivalent to<br/> 
		 * <code>?start-index=1&max-results=20</code>, because insertions and deletions could have taken place in between the two queries.</p>
		 *  
		 * @see http://code.google.com/apis/gdata/reference.html#Queries
		 */
		public function get start_index() : int
		{
			return __params.start_index;
		}
		
		/**
		 * @private
		 */
		public function set start_index(value : int) : void
		{
			__params.start_index = value;
			
			sendParams();
		}

		/**
		 * <p>Bridge to Authentication methods</p>
		 * 
		 * <p>Authentication to picasaweb can be done in two ways. <br/>
		 * ClientLogin - this method is used by installed Desktop Apps.<br/>
		 * AuthSub - this is the default method for web applications. However, this is not yet supported because of crossdomain.xml issue and Google Auth API.</p>
		 * 
		 */
		public function get auth() : Auth
		{
			return __auth;
		}

		/**
		 * Bridge to Photos methods
		 * 
		 */	
		public function get photos() : Photos
		{
			return __photos;
		}

		/**
		 * Bridge to Album methods 
		 * 
		 */	
		public function get albums() : Albums
		{
			return __albums;
		}

		/**
		 * Bridge to Tags methods
		 * 
		 */	
		public function get tags() : Tags
		{
			return __tags;
		}

		/**
		 * Bridge to Comments methods
		 * 
		 */	
		public function get comments() : Comments
		{
			return __comments;
		}

		/**
		 * Bridge to Community methods
		 * 
		 */	
		public function get community() : Community
		{
			return __community;
		}
		
		/**
		 * Bridge to Contacts methods
		 * 
		 */	
		public function get contacts() : Contacts
		{
			return __contacts;
		}
		
		/**
		 * <p>Dispatches each param change to the method objects<br/>
		 * Used to globaly change the UrlParams</p>
		 * 
		 * @private
		 */
		private function sendParams() : void
		{
			__paramsObservable.setObject(__params.clone());
		}
	}
}