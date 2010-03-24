package mainSuite.cases 
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.AtomFeed;

import flash.events.IOErrorEvent;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestService extends TestCase 
{
	protected var service : PicasaService;
	
	override protected function setUp() : void
	{
		service = new PicasaService();
	}
	
	override protected function tearDown() : void
	{
		service = null;
	}
	
	protected function handleTimeout(passThroughData : Object) : void
	{
		fail("Connection timed out");
	}
	
	public function testConnectionComplete() : void
	{
		var asyncHandler : Function = asyncHandler(handleConnectionComplete, 1500, null, handleTimeout);
		var responder : PicasaResponder = service.albums.list("picasaflashapi");
			responder.addEventListener(PicasaDataEvent.DATA, asyncHandler, false, 0, true);
	}
	
	protected function handleConnectionComplete(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		var tData : AtomFeed = evt.data as AtomFeed;
		
		assertNotNull("service exists", service);
		assertNotNull("we have some data", tData);
		assertTrue(tData.entries.length > 0);
		
		// TODO: is bug here? /api/ missing?
		assertEquals("id", "http://photos.googleapis.com/data/feed/user/picasaflashapi", tData.meta.id);
		assertEquals("http://schemas.google.com/g/2005#kind", tData.meta.category.scheme);
		assertEquals("http://schemas.google.com/photos/2007#user", tData.meta.category.term);
		
		assertEquals("picasaflashapi", tData.meta.title);
		
		var tRelLink : Link = tData.meta.links.find_by_rel(Link.REL_FEED);
		assertEquals(tRelLink.href, "http://photos.googleapis.com/data/feed/api/user/picasaflashapi?v=2");
		assertEquals(tRelLink.type, "application/atom+xml");
		
		var tAltLink : Link = tData.meta.links.find_by_rel(Link.REL_ALTERNATE);
		assertEquals(tAltLink.href, "http://picasaweb.google.com/picasaflashapi");
		assertEquals(tAltLink.type, "text/html");
		
		var tShowLink : Link = tData.meta.links.find_by_rel(Link.REL_SLIDESHOW);
		assertEquals(unescape(tShowLink.href), "http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http://photos.googleapis.com/data/feed/api/user/picasaflashapi?alt=rss");
		assertEquals(tShowLink.type, "application/x-shockwave-flash");
		
		var tSelfLink : Link = tData.meta.links.find_by_rel(Link.REL_SELF);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/picasaflashapi?start-index=1&max-results=1000&kind=album&v=2", tSelfLink.href);
		assertEquals("application/atom+xml", tSelfLink.type);
		
		assertEquals("Zuzana", tData.meta.author.name);
		assertEquals("http://picasaweb.google.com/picasaflashapi", tData.meta.author.uri);
		
		assertEquals("http://picasaweb.google.com/", tData.meta.generator.uri);
		assertEquals("1.00", tData.meta.generator.version);
		assertEquals("Picasaweb", tData.meta.generator.value);
		
		// missing openSearch properties
		//assertEquals(tData.meta.openSearch)
	}
	
	public function testConnectionUnknowUser() : void
	{
		var asyncHandler : Function = asyncHandler(handleConnectionFailed, 1500, null, handleTimeout);
		var responder : PicasaResponder = service.albums.list("does.not.exist");
			responder.addEventListener(IOErrorEvent.IO_ERROR, asyncHandler, false, 0, true);
	}
	
	protected function handleConnectionFailed(evt : IOErrorEvent, passThroughData : Object) : void
	{
		assertEquals(0, evt.text.indexOf("Error #2032: Stream Error. URL: http://photos.googleapis.com/data/feed/api/user/does.not.exist"));
		assertTrue(evt.target is PicasaResponder);
		assertEquals(IOErrorEvent.IO_ERROR, evt.type);
	}
	
	public function testMultipleConnections() : void
	{
		var service_a : PicasaService = new PicasaService();
		var service_b : PicasaService = new PicasaService();
		
		var asyncHandler_a : Function = asyncHandler(handleComplete_A, 1500, null, handleTimeout);
		var responder_a : PicasaResponder = service_a.albums.list("picasaflashapi");
			responder_a.addEventListener(PicasaDataEvent.DATA, asyncHandler_a, false, 0, true);
		
		var asyncHandler_b : Function = asyncHandler(handleComplete_B, 1500, null, handleTimeout);
		var responder_b : PicasaResponder = service_b.tags.user("picasaflashapi");
			responder_b.addEventListener(PicasaDataEvent.DATA, asyncHandler_b, false, 0, true);
	}
	
	protected function handleComplete_A(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		assertEquals(1, evt.data.entries.length); // one album
	}
	
	protected function handleComplete_B(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		assertEquals(2, evt.data.entries.length); // two tags
	}
}
}
