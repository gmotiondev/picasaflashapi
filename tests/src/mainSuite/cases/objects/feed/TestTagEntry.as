package mainSuite.cases.objects.feed 
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Author;
import sk.prasa.webapis.picasa.objects.Category;
import sk.prasa.webapis.picasa.objects.Kind;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
import sk.prasa.webapis.picasa.objects.feed.TagEntry;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestTagEntry extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "src/assets/fixtures/feed/api/tags/";	
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.tags.user("thisispinkfu");
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
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/lomo",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/brno",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/lc-a",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/tatry",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/lca",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/fisheye",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/salzburg",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/funsampler",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/bratislava",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/koloto%C4%8De",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/london",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/splitzer",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/colorsplash",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/scheisse",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/Stockholm",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/diana",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_01",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_02",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/cosina",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_03",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_04",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_05",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_06",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/Diana",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_07",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_08",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_09",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_10",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/pinhole",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/blog_post_11",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/slideshowsample",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/doubles"];
		
		var tag : TagEntry;
		
		for(var a : int = 0; a < atom.entries.length; a++)
		{
			tag = atom.entries[a] as TagEntry;
			
			assertEquals(ids[a], tag.id);
		}
		
		assertEquals("we have x tags", 32, atom.entries.length);
	}
	
	public function testEntry() : void
	{
		var tag : TagEntry = atom.entries[15] as TagEntry;
		
		assertNotNull("tag exists", tag);
		
		// title
		assertEquals("diana", tag.title);
		
		// links
		assertEquals("text/html", tag.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/lh/searchbrowse?q=diana&psc=G&uname=thisispinkfu&filter=0", tag.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", tag.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("rel_self", "http://photos.googleapis.com/data/entry/api/user/thisispinkfu/tag/diana?v=2", tag.links.find_by_rel(Link.REL_SELF).href);
		
		// authors
		assertEquals("author name", "Pink-fu", Author(tag.author).name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", Author(tag.author).uri);
		assertNull("author email", Author(tag.author).email);
				
		// content
		assertNotNull(tag.content);
		assertNull(tag.content.src);
		assertNull(tag.content.value);
		assertNull(tag.content.type);
		
		// category
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", Category(tag.category).scheme);
		assertEquals("category term", Kind.TAG, Category(tag.category).term);
		assertNull("category label", Category(tag.category).label);
		
		// id
		// TODO: bug? /api/ missing?
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/tag/diana", tag.id);
		
		// published
		assertNull("published value", tag.published);
		
		// updated 
		assertEquals("updated value", "Thu Aug 27 08:29:28 2009 UTC", tag.updated.toUTCString());
		
		// summary
		assertEquals("diana", tag.summary);
		
		// gphoto
		assertNotNull(tag.gphoto);
		assertEquals("gphoto:weight", 38, tag.gphoto.weight);
		
		// rights
		assertNull("rights value", tag.rights);
	}
}
}