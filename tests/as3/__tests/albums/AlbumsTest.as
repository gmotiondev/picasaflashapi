package albums
{
	import flexunit.framework.TestCase;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.Category;
	import sk.prasa.webapis.picasa.objects.Link;
	import sk.prasa.webapis.picasa.objects.Links;
	import sk.prasa.webapis.picasa.objects.Text;
	import sk.prasa.webapis.picasa.objects.feed.AlbumEntry;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
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
			var tData : AtomFeed = evt.data as AtomFeed;
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
			
			// Meta:Category
			assertNull("meta.category.label is not null", Category(tMeta.categories[0]).label);
			assertEquals("meta.category.scheme", Category(tMeta.categories[0]).scheme, "http://schemas.google.com/g/2005#kind");
			assertEquals("meta.category.term", Category(tMeta.categories[0]).term, "http://schemas.google.com/photos/2007#user");
			 
			// Meta:Title
			assertNotNull("meta.title.type is null", tMeta.title.type);
			assertNotNull("meta.title.value is null", tMeta.title.value);
			assertTrue("meta.title.type", tMeta.title.type == Text.TYPE_TEXT);
			assertEquals("meta.title.value", tMeta.title.value, "thisispinkfu");
			
			// Meta:Subtitle
			assertNotNull("meta.subtitle.type is null", tMeta.subtitle.type);
			assertNull("meta.subtitle.value is not null", tMeta.subtitle.value);
			assertTrue("meta.subtitle.type", tMeta.subtitle.type == Text.TYPE_TEXT);

			// Meta:Icon
			assertNotNull("meta.icon is null", tMeta.icon);
			assertEquals("meta.ico", tMeta.icon, "http://lh6.ggpht.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu.jpg");
			
			// Meta:Links
			var tLinks : Links = tMeta.links as Links;
			// 0
			assertNotNull("meta.link[0]href is null", Link(tLinks[0]).href);
			assertTrue("meta.link[0].href == ...", Link(tLinks[0]).href == "http://photos.googleapis.com/data/feed/api/user/thisispinkfu");
			assertNotNull("meta.link[0].rel is null", Link(tLinks[0]).rel);
			assertTrue("meta.link[0].rel == ...", Link(tLinks[0]).rel == Link.REL_FEED);
			assertNotNull("meta.link[0].type is null", Link(tLinks[0]).type);
			assertTrue("meta.link[0].type == ...", Link(tLinks[0]).type == "application/atom+xml");
			
			// 1
			assertNotNull("meta.link[1]href is null", Link(tLinks[1]).href);
			assertTrue("meta.link[1].href == ...", Link(tLinks[1]).href == "http://picasaweb.google.com/thisispinkfu");
			assertNotNull("meta.link[1].rel is null", Link(tLinks[1]).rel);
			assertTrue("meta.link[1].rel == ...", Link(tLinks[1]).rel == Link.REL_ALTERNATE);
			assertNotNull("meta.link[1].type is null", Link(tLinks[1]).type);
			assertTrue("meta.link[1].type == ...", Link(tLinks[1]).type == "text/html");
			
			// 2
			assertNotNull("meta.link[2]href is null", Link(tLinks[2]).href);
			assertTrue("meta.link[2].href == ..." + Link(tLinks[2]).href, Link(tLinks[2]).href == "http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fphotos.googleapis.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%3Falt%3Drss");
			assertNotNull("meta.link[2].rel is null", Link(tLinks[2]).rel);
			assertTrue("meta.link[2].rel == ...", Link(tLinks[2]).rel == Link.REL_SLIDESHOW);
			assertNotNull("meta.link[2].type is null", Link(tLinks[2]).type);
			assertTrue("meta.link[2].type == ...", Link(tLinks[2]).type == "application/x-shockwave-flash");
			
			// 3
			assertNotNull("meta.link[3]href is null", Link(tLinks[3]).href);
			assertTrue("meta.link[3].href == ..." + Link(tLinks[3]).href, Link(tLinks[3]).href == "http://photos.googleapis.com/data/feed/api/user/thisispinkfu?start-index=1&max-results=100&kind=album");
			assertNotNull("meta.link[3].rel is null", Link(tLinks[3]).rel);
			assertTrue("meta.link[3].rel == ...", Link(tLinks[3]).rel == Link.REL_SELF);
			assertNotNull("meta.link[3].type is null", Link(tLinks[3]).type);
			assertTrue("meta.link[3].type == ...", Link(tLinks[3]).type == "application/atom+xml");
			
			assertEquals("links.getByRel", Link(tLinks.getByRel(Link.REL_FEED)).href, "http://photos.googleapis.com/data/feed/api/user/thisispinkfu"); 
			assertEquals("links.getByRel", Link(tLinks.getByRel(Link.REL_ALTERNATE)).href, "http://picasaweb.google.com/thisispinkfu");
			assertEquals("links.getByRel", Link(tLinks.getByRel(Link.REL_SLIDESHOW)).href, "http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fphotos.googleapis.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%3Falt%3Drss");
			assertEquals("links.getByRel", Link(tLinks.getByRel(Link.REL_SELF)).href, "http://photos.googleapis.com/data/feed/api/user/thisispinkfu?start-index=1&max-results=100&kind=album");
			
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