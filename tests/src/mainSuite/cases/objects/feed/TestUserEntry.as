package mainSuite.cases.objects.feed 
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
import sk.prasa.webapis.picasa.objects.feed.UserEntry;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestUserEntry extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "src/assets/fixtures/feed/api/";	
		
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
	
	public function testEntries() : void
	{
		// TODO: bug? /api/ is missing?
		var ids : Array = [
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/jan.rumann",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/davidtravnicek",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/ondrafanta",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/slowatch",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/juraj.gabrhel",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/kvenda"
		];
		
		var user : UserEntry;
		
		for(var a : int = 0; a < atom.entries.length; a++)
		{
			user = atom.entries[a] as UserEntry;
			
			assertEquals(ids[a], user.id);
		}
	}
	
	public function testEntry() : void
	{
		//var user : UserEntry = atom.entries.last;
		var user : UserEntry = atom.entries[atom.entries.length - 1];
		
		assertNotNull(user);
		
		// title
		assertEquals("kvenda", user.title);
		
		// links
		// TODO: rel_feed doesn't have /api/ alternate has!
		assertEquals("application/atom+xml", user.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("rel_feed", "http://photos.googleapis.com/data/feed/user/kvenda?v=2", user.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", user.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/kvenda", user.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", user.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("rel_self", "http://photos.googleapis.com/data/entry/api/user/thisispinkfu/contacts/kvenda?v=2", user.links.find_by_rel(Link.REL_SELF).href);
		
		// authors
		assertEquals("author name", "dasa", user.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/kvenda", user.author.uri);
		assertNull("author email", user.author.email);
		
		// content
		assertNotNull(user.content);
		assertNull(user.content.src);
		assertNull(user.content.value);
		assertNull(user.content.type);
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", user.category.scheme);
		assertEquals("category term", "http://schemas.google.com/photos/2007#user", user.category.term);
		assertNull("category label", user.category.label);
		
		// id
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/contacts/kvenda", user.id);
		
		// published 
		assertEquals("published value", "Sat Aug 29 10:44:36 2009 UTC", user.published.toUTCString());
		
		// updated
		assertEquals("updated value", "Sat Aug 29 10:44:36 2009 UTC", user.updated.toUTCString());
		
		// summary
		assertNull(user.summary);
		
		// rights
		assertNull("rights", user.rights);

		// gphoto
		assertNotNull(user.gphoto);
		assertEquals("gphoto:user", "kvenda", user.gphoto.user);
		assertEquals("gphoto:nickname", "dasa", user.gphoto.nickname);
		assertEquals("gphoto:thumbnail", "http://lh6.ggpht.com/_Uj9ejORqf8w/AAAAvrHUTp0/AAAAAAAAAAA/aGg5jy0-aqA/s64-c/kvenda.jpg", user.gphoto.thumbnail);
	}
}
}
