package mainSuite.cases.objects.feed 
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Kind;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.AlbumEntry;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestAlbumEntry extends TestBase
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
	
	// test one for gphoto 
	// test one for media, geo, opensearch
	// test all just for ids?
	public function testEntries() : void
	{
		var ids : Array = [
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5296410852174025857",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5299416471336243009",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5361754817804669393",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5349706556832622129",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5349715860270062337",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5360642923029263889",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5360654252054942945",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5245242894316557489",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5285299988289648865",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5225576194588830593",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135047888133059345",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135048841615799345",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135049309767234945",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135049790803572289",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135050512358078113",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135051345581734225",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5135053372806298689",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5150986992011782785",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5094406297232552993",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5046158866819398449",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5050296046189129633",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/4991254969496895505"
		];
		
		var entry : AlbumEntry;
		
		for(var a : int = 0; a < atom.entries.length; a++)
		{
			entry = atom.entries[a];
			
			assertEquals(ids[a], entry.id);
		}
	}
	
	public function testEntry() : void
	{
		var entry : AlbumEntry = atom.entries[3];	// this is the Ljubljana entry
		
		// title
		assertEquals("Ljubljana", entry.title);
		
		// links
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5349706556832622129?v=2", entry.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu/Ljubljana", entry.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5349706556832622129?v=2", entry.links.find_by_rel(Link.REL_SELF).href);
		
		// author
		assertEquals("author name", "Pink-fu", entry.author.name);
		assertEquals("author uri", "http://picasaweb.google.com/thisispinkfu", entry.author.uri);
		assertNull("author email", entry.author.email);
		
		// content
		assertNotNull(entry.content);
		assertNull(entry.content.src);
		assertNull(entry.content.value);
		assertNull(entry.content.type);
		
		// category
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", entry.category.scheme);
		assertEquals("category term", Kind.ALBUM, entry.category.term);
		assertNull("category label", entry.category.label);
		
		// id, // TODO: THIS URI DOESN'T WORK!
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5349706556832622129", entry.id);
		
		// published 2010-12-23T08:00:00.000Z
		assertEquals("published value", "Thu Dec 23 08:00:00 2010 UTC", entry.published.toUTCString());
		
		// updated 2009-06-21T10:15:53.566Z
		assertEquals("updated value", "Sun Jun 21 10:15:53 2009 UTC", entry.updated.toUTCString());
		
		// summary
		assertNull("summary is null", entry.summary);
		
		// rights
		assertEquals("public", entry.rights);
		
		// gphoto
		assertNotNull("gphoto", entry.gphoto);
		assertEquals("gphoto:kind", Kind.ALBUM, entry.gphoto.kind);
		assertNull("gphoto:albumid", entry.gphoto.albumid);	// valid only with the photo and comment type!
		assertEquals("gphoto:id", "5349706556832622129", entry.gphoto.id);
		
		assertEquals("gphoto:access", "public", entry.gphoto.access);
		assertEquals("gphoto:bytesUsed", 0, entry.gphoto.bytesUsed);	// only if authenticated user is owner  
		assertEquals("gphoto:location", "Ljubljana", entry.gphoto.location);
		assertEquals("gphoto:numphotos", 34, entry.gphoto.numphotos);
		assertEquals("gphoto:numphotosremaining", 0, entry.gphoto.numphotosremaining);	// only if authenticated user is owner
		
		// media
		assertNotNull("media", entry.media);
		assertEquals("media:content url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/Sj35xPyWJjE/AAAAAAAAEDY/V5Pjd-3NmbY/Ljubljana.jpg", entry.media.content.url);
		assertEquals("media:content type", "image/jpeg", entry.media.content.type);
		assertEquals("media:content medium", "image", entry.media.content.medium);
		assertTrue("media:content width ", isNaN(entry.media.content.width));
		assertTrue("media:content height", isNaN(entry.media.content.height));
		assertTrue("media:content fileSize", isNaN(entry.media.content.fileSize));
		assertEquals("media:credit", "Pink-fu", entry.media.credit);
		assertNull("media:description", entry.media.description);
		assertTrue("media:keywords is array", entry.media.keywords is Array);
		assertEquals("media:keywords length", 0, entry.media.keywords.length);
		assertTrue("media:thumbnails", entry.media.thumbnails is Array);
		assertEquals("media:thumbnails has 1 element", 1, entry.media.thumbnails.length);
		assertEquals("media:thumbnail url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/Sj35xPyWJjE/AAAAAAAAEDY/V5Pjd-3NmbY/s160-c/Ljubljana.jpg", entry.media.thumbnail.url);
		assertEquals("media:thumbnail url", 160, entry.media.thumbnail.width);
		assertEquals("media:thumbnail url", 160, entry.media.thumbnail.height);
		assertEquals("media:title", "Ljubljana", entry.media.title);
		
		// georss
		// todo: needs to add Envelope and test it
		assertNotNull("georss:where", entry.geo);
		assertEquals("latitude", "46.051426", entry.geo.latitude);
		assertEquals("longitude", "14.505965", entry.geo.longitude);
		
		// TODO: 
//		<entry gd:etag="&quot;Wyp7ImA5&quot;">
 
//		<gphoto:timestamp>1293091200000</gphoto:timestamp>
//		<gphoto:user>thisispinkfu</gphoto:user>
//		<gphoto:nickname>Pink-fu</gphoto:nickname>

//		<georss:where>
//			<gml:Envelope>
//				<gml:lowerCorner>45.9313375 14.201781</gml:lowerCorner>
//				<gml:upperCorner>46.1715144 14.8101489</gml:upperCorner>
//			</gml:Envelope>
//		</georss:where>
	}
}
}
