package albums
{
	import flexunit.framework.TestCase;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.Category;
	import sk.prasa.webapis.picasa.objects.feed.AlbumEntry;
	import sk.prasa.webapis.picasa.objects.feed.AlbumFeed;
	import sk.prasa.webapis.picasa.objects.feed.AlbumMeta;
	import sk.prasa.webapis.picasa.objects.feed.UserFeed;
	import sk.prasa.webapis.picasa.objects.feed.UserMeta;

	/**
	 * handle asynchronous test, 
	 * IO Errors, Sandbox Violation Errors, TimeOut Errors ...
	 * 
	 */
	public class AlbumsTest extends TestCase
	{
		private var __service : PicasaService;
		private const USER : String = "thisispinkfu";
		
		public function AlbumsTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp() : void
		{
			__service = new PicasaService();
		}
		
		override public function tearDown():void
		{
			// tear down listeners?
		}
		
		public function testList() : void
		{
			var tResponder : PicasaResponder = __service.albums.list(USER);
				tResponder.addEventListener(PicasaDataEvent.DATA, addAsync(onListData, 5000));
		}
		
		private function onListData(evt : PicasaDataEvent) : void
		{
			var tData : UserFeed = evt.data as UserFeed;
			var tMeta : UserMeta = evt.data.meta as UserMeta;
			var tEntries : Array = evt.data.entries;
			var tEntry : AlbumEntry = evt.data.entries[0];
			
			// Feed
			assertNotNull("evt.data is null", tData);
			assertNotNull("evt.data.meta is null", tMeta);
			assertNotNull("evt.data.entries is null", tEntries);
			assertTrue("evt.data has no children", tData.entries.length > 0);
			
			// Meta
			assertEquals("meta.id", tMeta.id, "http://photos.googleapis.com/data/feed/api/user/thisispinkfu");
			//assertEquals("meta.updated", tMeta.updated.toUTCString(), "Thu Jul 19 22:13:56 2008 UTC");
			
			assertNull("meta.category.label is not null", Category(tMeta.categories[0]).label);
			assertEquals("meta.category.scheme", Category(tMeta.categories[0]).scheme, "http://schemas.google.com/g/2005#kind");
			assertEquals("meta.category.term", Category(tMeta.categories[0]).term, "http://schemas.google.com/photos/2007#user");
			 
			// TODO: ...
		}
		/*		
			<id>http://picasaweb.google.com/data/feed/api/user/thisispinkfu</id>
			<updated>2008-06-19T22:13:56.436Z</updated>
			<category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#user'/>
			<title type='text'>thisispinkfu</title>
			<subtitle type='text'></subtitle>
			<icon>http://lh6.ggpht.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu.jpg</icon>
			<link rel='http://schemas.google.com/g/2005#feed' type='application/atom+xml' href='http://picasaweb.google.com/data/feed/api/user/thisispinkfu'/>
			<link rel='alternate' type='text/html' href='http://picasaweb.google.com/thisispinkfu'/>
			<link rel='http://schemas.google.com/photos/2007#slideshow' type='application/x-shockwave-flash' href='http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&amp;RGB=0x000000&amp;feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%3Falt%3Drss'/>
			<link rel='self' type='application/atom+xml' href='http://picasaweb.google.com/data/feed/api/user/thisispinkfu?start-index=1&amp;max-results=1000&amp;kind=album'/>
			<author>
				<name>Pink-fu</name>
				<uri>http://picasaweb.google.com/thisispinkfu</uri>
			</author>
			<generator version='1.00' uri='http://picasaweb.google.com/'>Picasaweb</generator>
			<openSearch:totalResults>15</openSearch:totalResults>
			<openSearch:startIndex>1</openSearch:startIndex>
			<openSearch:itemsPerPage>1000</openSearch:itemsPerPage>
			<gphoto:user>thisispinkfu</gphoto:user>
			<gphoto:nickname>Pink-fu</gphoto:nickname>
			<gphoto:thumbnail>http://lh6.ggpht.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu.jpg</gphoto:thumbnail>
		*/
	}
}