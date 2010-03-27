package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.Entry;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestEntry extends TestBase 
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
	
	public function testEntries() : void
	{
		assertEquals("entries length", 23, atom.entries.length);
		
		var entry : Entry = atom.entries[0] as Entry;
		
		// title
		assertEquals("Pinholes", entry.title);
		
		// links
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("rel_feed", "http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5296410852174025857?v=2", entry.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu/Pinholes", entry.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("rel_self", "http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5296410852174025857?v=2", entry.links.find_by_rel(Link.REL_SELF).href);
		
		// published
		assertEquals("published value", entry.published.toUTCString(), "Thu Dec 23 10:31:53 2010 UTC");
		
		// authors
		assertEquals("author name", "Pink-fu", entry.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", entry.author.uri);
		assertNull("author email", entry.author.email);
				
		// content
		assertNotNull(entry.content);
		assertNull(entry.content.src);
		assertNull(entry.content.value);
		assertNull(entry.content.type);
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", entry.category.scheme);
		assertEquals("category term", "http://schemas.google.com/photos/2007#album", entry.category.term);
		assertNull("category label", entry.category.label);
		
		// id
		// TODO: bug? /api/ in url is missing?
		// was http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5296410852174025857
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5296410852174025857", entry.id);
		
		// updated
		assertEquals("updated value", entry.updated.toUTCString(), "Fri Mar 27 22:40:51 2009 UTC");
		
		// summary
		assertEquals("Sharan STD-35 and Diana pinholes", entry.summary);
	}
}
}
