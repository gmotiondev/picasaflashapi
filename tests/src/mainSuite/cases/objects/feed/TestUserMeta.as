package mainSuite.cases.objects.feed
{
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.Link;
	import sk.prasa.webapis.picasa.objects.feed.UserMeta;
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestUserMeta extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/";	
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.contacts.list("thisispinkfu");
			responder.addEventListener( PicasaDataEvent.DATA, 
										asyncHandler(setUpComplete, 1000),
										false, 0, true);
	}
	
	override protected function tearDown() : void
	{
		fixtures_path = null;
		atom = null;
	}
	
	protected function setUpComplete(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		atom = evt.data;
	}
	
	public function testMeta() : void
	{
		var meta : UserMeta = atom.meta as UserMeta;
		
		assertNotNull("meta exists!", meta);
		assertTrue(atom.meta is UserMeta);
		
		// test title
		assertEquals("thisispinkfu", meta.title);
		
		// test links 
		assertEquals(3, meta.links.length);
		assertEquals("application/atom+xml", meta.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu/contacts?v=2", meta.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", meta.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/lh/favorites?uname=thisispinkfu", meta.links.find_by_rel(Link.REL_ALTERNATE).href);
	
		assertEquals("application/atom+xml", meta.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu/contacts?start-index=1&max-results=500&v=2", meta.links.find_by_rel(Link.REL_SELF).href);
		
		// subtitle
		assertNull("subtitle", meta.subtitle);
			
		// updated 2009-08-29T10:44:36.757Z
		assertEquals("updated value", "Sat Aug 29 10:44:36 2009 UTC", meta.updated.toUTCString());
		
		// id, was http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521
		// is this a bug? that /api/ is missing?
		assertEquals("id", "http://photos.googleapis.com/data/feed/user/thisispinkfu/contacts", meta.id);
		
		// authors
		assertEquals("author name", "Pink-fu", meta.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", meta.author.uri);
		assertNull("author email", meta.author.email);
		
		
		// category
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", meta.category.scheme);
		assertEquals("category term", Kind.USER, meta.category.term);
		assertNull("category label", meta.category.label);
		
		// rights
		assertNull("right value", meta.rights);
		
		// generator
		assertNotNull("generator", meta.generator);
		assertEquals("generator uri", "http://picasaweb.google.com/", meta.generator.uri);
		assertEquals("generator value", "Picasaweb", meta.generator.value);
		assertEquals("generator version", "1.00", meta.generator.version);
		
		// icon
		assertEquals("icon", "http://lh6.ggpht.com/_7xTZSmvyUmQ/AAAAY-cVBS8/AAAAAAAAAAA/N103ygsWNXU/s64-c/thisispinkfu.jpg", meta.icon);
		
		// logo
		assertNull("logo", meta.logo);
		
		// opensearch
		assertEquals("openSearch:totalResults", 6, meta.opensearch.totalResults);
		assertEquals("openSearch:startIndex", 1, meta.opensearch.startIndex);
		assertEquals("openSearch:itemsPerPage", 500, meta.opensearch.itemsPerPage);
		
		// gphoto
		assertNull("gphoto:albumid", meta.gphoto.albumid);
		assertNull("gphoto:id", meta.gphoto.id);
		assertEquals("gphoto:user", "thisispinkfu", meta.gphoto.user);
		assertEquals("gphoto:nickname", "Pink-fu", meta.gphoto.nickname);
		assertEquals("gphoto:thumbnail", "http://lh6.ggpht.com/_7xTZSmvyUmQ/AAAAY-cVBS8/AAAAAAAAAAA/N103ygsWNXU/s64-c/thisispinkfu.jpg", meta.gphoto.thumbnail);
	}
}
}
