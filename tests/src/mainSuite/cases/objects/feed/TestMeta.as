package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.*;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestMeta extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/";
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.albums.list("thisispinkfu");
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
	
	// just test general Meta class
	// other test will cover UserMeta, AlbumMeta etc..
	public function testMeta() : void
	{
		// test title
		assertEquals("thisispinkfu", atom.meta.title);
		
		// test links 
		assertEquals(4, atom.meta.links.length);
		assertEquals("application/atom+xml", atom.meta.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu?v=2", atom.meta.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", atom.meta.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu", atom.meta.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/x-shockwave-flash", atom.meta.links.find_by_rel(Link.REL_SLIDESHOW).type);
		assertEquals("http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fphotos.googleapis.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%3Falt%3Drss", atom.meta.links.find_by_rel(Link.REL_SLIDESHOW).href);
		
		assertEquals("application/atom+xml", atom.meta.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu?start-index=1&max-results=1000&v=2", atom.meta.links.find_by_rel(Link.REL_SELF).href);
		
		// subtitle
		assertNull("subtitle", atom.meta.subtitle);
		
		// updated
		assertEquals("updated value", "Thu Aug 27 08:29:28 2009 UTC", atom.meta.updated.toUTCString());
		
		// id
		// TODO: bug? /api/ is missing?
		// was http://photos.googleapis.com/data/feed/api/user/thisispinkfu
		assertEquals("id", "http://photos.googleapis.com/data/feed/user/thisispinkfu", atom.meta.id);
		
		// authors
		assertEquals("author name", "Pink-fu", atom.meta.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", atom.meta.author.uri);
		assertNull("author email", atom.meta.author.email);
				
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", atom.meta.category.scheme);
		assertEquals("category term", "http://schemas.google.com/photos/2007#user", atom.meta.category.term);
		assertNull("category label", atom.meta.category.label);
		
		// rights
		assertNull("rights", atom.meta.rights);
		
		// generator
		assertNotNull("generator", atom.meta.generator);
		assertEquals("generator uri", "http://picasaweb.google.com/", atom.meta.generator.uri);
		assertEquals("generator value", "Picasaweb", atom.meta.generator.value);
		assertEquals("generator version", "1.00", atom.meta.generator.version);
		
		// icon
		assertEquals("icon", "http://lh6.ggpht.com/_7xTZSmvyUmQ/AAAAY-cVBS8/AAAAAAAAAAA/N103ygsWNXU/s64-c/thisispinkfu.jpg", atom.meta.icon);
		
		// logo
		assertNull("logo", atom.meta.logo);
	}
}
}
