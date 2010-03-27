package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Kind;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.AlbumMeta;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestAlbumMeta extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/";
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.photos.list("thisispinkfu","5161355527636525521");
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
		var meta : AlbumMeta = atom.meta as AlbumMeta;
		
		// test title
		assertEquals("Diana", meta.title);
		
		// test links 
		assertEquals(5, meta.links.length);
		assertEquals("application/atom+xml", meta.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521?v=2", meta.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", meta.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu/Diana", meta.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/x-shockwave-flash", meta.links.find_by_rel(Link.REL_SLIDESHOW).type);
		assertEquals("http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fphotos.googleapis.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%2Falbumid%2F5161355527636525521%3Falt%3Drss", meta.links.find_by_rel(Link.REL_SLIDESHOW).href);
		
		assertEquals("application/atom+xml", meta.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521?start-index=1&max-results=1000&v=2", meta.links.find_by_rel(Link.REL_SELF).href);
		
		assertEquals("text/html", meta.links.find_by_rel(Link.REL_REPORT_ABUSE).type);
		assertEquals("http://picasaweb.google.com/lh/reportAbuse?uname=thisispinkfu&aid=5161355527636525521", meta.links.find_by_rel(Link.REL_REPORT_ABUSE).href);
		
		// subtitle
		assertNull("subtitle", meta.subtitle);
			
		// updated 2009-07-12T11:12:12.319Z
		assertEquals("updated value", "Sun Jul 12 11:12:12 2009 UTC", meta.updated.toUTCString());
		
		// id, was http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521
		// is this a bug? that /api/ is missing?
		assertEquals("id", "http://photos.googleapis.com/data/feed/user/thisispinkfu/albumid/5161355527636525521", meta.id);
		
		// authors
		assertEquals("author name", "Pink-fu", meta.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", meta.author.uri);
		assertNull("author email", meta.author.email);
		
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", meta.category.scheme);
		assertEquals("category term", Kind.ALBUM, meta.category.term);
		assertNull("category label", meta.category.label);
		
		// rights
		assertEquals("right value", "public", meta.rights);
		
		// generator
		assertNotNull("generator", meta.generator);
		assertEquals("generator uri", "http://picasaweb.google.com/", meta.generator.uri);
		assertEquals("generator value", "Picasaweb", meta.generator.value);
		assertEquals("generator version", "1.00", meta.generator.version);
		
		// icon
		assertEquals("icon", "http://lh3.ggpht.com/_7xTZSmvyUmQ/R6DRgaBGIdE/AAAAAAAAEJw/sdbZKfiim-E/s160-c/Diana.jpg", meta.icon);
		
		// logo
		assertNull("logo", meta.logo);
		
		assertEquals("openSearch:totalResults", 83, meta.opensearch.totalResults);
		assertEquals("openSearch:startIndex", 1, meta.opensearch.startIndex);
		assertEquals("openSearch:itemsPerPage", 1000, meta.opensearch.itemsPerPage);
		
		assertNull("gphoto:albumid", meta.gphoto.albumid);
		assertEquals("gphoto:id", "5161355527636525521", meta.gphoto.id);
		assertEquals("gphoto:access", "public", meta.gphoto.access);
		assertEquals("gphoto:bytesUsed", 0, meta.gphoto.bytesUsed); // only auth. owner
		assertEquals("gphoto:location", "Slovakia", meta.gphoto.location);
		assertEquals("gphoto:numphotos", 83, meta.gphoto.numphotos);
		assertEquals("gphoto:numphotosremaining", 0, meta.gphoto.numphotosremaining);
		
		// georss
		// todo: needs to add Envelope and test it
		assertNotNull("georss:where", meta.geo);
		assertEquals("latitude", "48.6690259", meta.geo.latitude);
		assertEquals("longitude", "19.6990239", meta.geo.longitude);
		
		// ostalo toto:
//	<gphoto:name>Diana</gphoto:name>
//	<gphoto:timestamp>1206342000000</gphoto:timestamp>
//	<gphoto:user>thisispinkfu</gphoto:user>
//	<gphoto:nickname>Pink-fu</gphoto:nickname>
//	<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
//	<gphoto:commentCount>0</gphoto:commentCount>
//	<gphoto:allowPrints>true</gphoto:allowPrints>
//	<gphoto:allowDownloads>true</gphoto:allowDownloads>
		
	}
}
}
