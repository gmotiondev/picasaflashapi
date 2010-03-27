package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.CommentEntry;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestCommentEntry extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/comment/";
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.comments.user("picasaflashapi");
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
		// TODO: bug? /api/ from url missing!
		var comment : CommentEntry;
		var ids : Array = [
				"http://photos.googleapis.com/data/entry/user/picasaflashapi/albumid/5134889498689547361/photoid/5134889597473795202/commentid/5135374013950209316"
			];
		
		assertEquals(1, atom.entries.length);	
		
		for(var a : int = 0; a < atom.entries.length; a++)
		{
			comment = atom.entries[a] as CommentEntry;
			assertEquals(ids[a], comment.id);
		}
	}
	
	public function testEntry() : void
	{
		// atom.entries.first;
		var comment : CommentEntry = atom.entries[0] as CommentEntry;
		
		assertNotNull("comment exists", comment);
		
		// title
		assertEquals("Zuzana", comment.title);
		
		// links
		assertEquals("text/html", comment.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/lh/photo/wnuo6KQdFZND6kTwu-AD1Q", comment.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", comment.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("http://photos.googleapis.com/data/entry/api/user/picasaflashapi/albumid/5134889498689547361/photoid/5134889597473795202/commentid/5135374013950209316?v=2", comment.links.find_by_rel(Link.REL_SELF).href);
		
		// authors
		assertEquals("author name", "Zuzana", comment.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/picasaflashapi", comment.author.uri);
		assertNull("author email", comment.author.email);
		
		// content
		assertNotNull(comment.content);
		assertNull(comment.content.src);
		assertEquals("Hey, this number is even, not odd!", comment.content.value);
		assertNull("text", comment.content.type);
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", comment.category.scheme);
		assertEquals("category term", "http://schemas.google.com/photos/2007#comment", comment.category.term);
		assertNull("category label", comment.category.label);
		
		// id
		// TODO: bug? /api/ missing from url?
		assertEquals("http://photos.googleapis.com/data/entry/user/picasaflashapi/albumid/5134889498689547361/photoid/5134889597473795202/commentid/5135374013950209316", comment.id);
		
		// published
		assertEquals("published value", "Wed Nov 21 19:13:57 2007 UTC", comment.published.toUTCString());
		
		// updated 
		assertEquals("updated value", "Wed Nov 21 19:13:57 2007 UTC", comment.updated.toUTCString());
		
		// summary
		assertNull(comment.summary);
		
		// rights
		assertNull("rights", comment.rights);
		
		// gphoto
		assertNotNull(comment.gphoto);
		assertEquals("gphoto:id", "5135374013950209316", comment.gphoto.id);
		assertEquals("gphoto:photoid", "5134889597473795202", comment.gphoto.photoid);
		
		// gphoto_hack
		assertEquals("gphoto:user", "picasaflashapi", comment.user.user);
		assertEquals("gphoto:nickname", "Zuzana", comment.user.nickname);
		assertEquals("gphoto:thumbnail", "http://lh4.ggpht.com/_T_B0atmbR8I/AAAA84DinGg/AAAAAAAAAAA/TbZBoKqU4oc/s48-c/picasaflashapi.jpg", comment.user.thumbnail);
	}
}
}
