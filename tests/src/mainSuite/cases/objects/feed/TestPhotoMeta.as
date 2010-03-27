package mainSuite.cases.objects.feed
{
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.Link;
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
	import sk.prasa.webapis.picasa.objects.feed.PhotoMeta;
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestPhotoMeta extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/";
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.photos.single("thisispinkfu", "5161355527636525521", "5254155346833772338");
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
		assertNotNull("there is a meta, but not real one.. should be empty!!", atom.meta);
		assertNull("e.g. the id is null on the meta", atom.meta.id);
		assertNotNull("but there are entries!", atom.entries);
		assertEquals("exactly one entry!", 1, atom.entries.length);
		
		assertNotNull("you can access it also via entry", (atom as AtomFeed).entry);
	}
	
	public function testEntry() : void
	{
		var entry : PhotoEntry = (atom as AtomFeed).entry as PhotoEntry;
		
		// entry is not null
		assertNotNull("entry exixts!", entry);
		
		// title
		assertEquals("33880006.jpg", entry.title);
		
		// links
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("rel_feed", "http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155346833772338?v=2", entry.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu/Diana#5254155346833772338", entry.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("rel_self", "http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155346833772338?v=2", entry.links.find_by_rel(Link.REL_SELF).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_CANONICAL).type);
		assertEquals("http://picasaweb.google.com/lh/photo/juiQEO0ftwPXc5mewam4BA", entry.links.find_by_rel(Link.REL_CANONICAL).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_REPORT_ABUSE).type);
		assertEquals("http://picasaweb.google.com/lh/reportAbuse?uname=thisispinkfu&aid=5161355527636525521&iid=5254155346833772338", entry.links.find_by_rel(Link.REL_REPORT_ABUSE).href);
		
		// authors
		assertNotNull("author", 0, entry.author);
		assertNull("author.email", entry.author.email);
		assertNull("author.name", entry.author.name);
		assertNull("author.uri", entry.author.uri);
				
		// content
		assertNotNull(entry.content);
		assertEquals("content src", "http://lh5.ggpht.com/_7xTZSmvyUmQ/SOqCc0K_DzI/AAAAAAAACJY/AUgV83nbi9E/33880006.jpg", entry.content.src);
		assertNull("content value", entry.content.value); // todo: should be the same as src when photoentry?
		assertEquals("content type", "image/jpeg", entry.content.type);
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", entry.category.scheme);
		assertEquals("category term", Kind.PHOTO, entry.category.term);
		assertNull("category label", entry.category.label);
		
		// id
		// TODO: bug? /api/ missing?
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155346833772338", entry.id);
		
		// published 2008-10-06T21:26:01.000Z
		assertEquals("published value", "Mon Oct 6 21:26:11 2008 UTC", entry.published.toUTCString());
		
		// updated 2009-06-25T07:17:22.091Z
		assertEquals("updated value", "Thu Jun 25 07:17:22 2009 UTC", entry.updated.toUTCString());
		
		// summary
		assertEquals("Lomography.sk workshop 10/2007 / Jednota", entry.summary);
		
		// rights
		assertNull("rights is null", entry.rights);
		
		// gphoto
		assertEquals("gphoto:kind", Kind.PHOTO, entry.gphoto.kind);
		assertEquals("gphoto:albumid", "5161355527636525521", entry.gphoto.albumid);	// valid only with the photo and comment type!
		assertEquals("gphoto:id", "5254155346833772338", entry.gphoto.id);
	
		assertNotNull("gphoto", entry.gphoto);
		assertEquals("gphoto:checksum", "a761fdf", entry.gphoto.checksum);
		assertEquals("gphoto:commentCount", 0, entry.gphoto.commentCount);
		assertEquals("gphoto:height", 800, entry.gphoto.height);
		assertEquals("gphoto:rotation", 0, entry.gphoto.rotation);
		assertEquals("gphoto:size", 248134, entry.gphoto.size);
		assertEquals("gphoto:timestamp", 1223148176000, entry.gphoto.timestamp);
		assertNull("gphoto:videostatus", entry.gphoto.videostatus);
		assertEquals("gphoto:width", 800, entry.gphoto.width);
		

		// photo entries search result feed
		assertNull(entry.gphoto.albumtitle);
		assertNull(entry.gphoto.albumdesc);
		assertNull(entry.gphoto.snippet);
		assertNull(entry.gphoto.snippettype);
		assertFalse(entry.gphoto.truncated);
		
		// Some extra stuff we need to identify agains API reference!
//		<gphoto:access>public</gphoto:access>
//		<gphoto:imageVersion>2198</gphoto:imageVersion>
//		<gphoto:viewCount>27</gphoto:viewCount>
		
		
		// exif
		assertNotNull("exif exists", entry.exif);
		assertEquals("exif:make", "NORITSU KOKI", entry.exif.make);
		assertEquals("exif:model", "QSS-32_33", entry.exif.model);
		assertEquals("exif:imageUniqueID", "cb397bd4b699bd18116010e91ae4258a", entry.exif.imageUniqueID);
		assertTrue("exif:distance", isNaN(entry.exif.distance));
		assertTrue("exif:exposure", isNaN(entry.exif.exposure));
		assertFalse("exif:flash", entry.exif.flash);
		
		assertTrue("exif:focallength", isNaN(entry.exif.focallength));
		assertTrue("exif:fstop", isNaN(entry.exif.fstop));
		assertTrue("exif:iso", isNaN(entry.exif.iso));
		assertTrue("exif:time", isNaN(entry.exif.time));

		// media
		assertNotNull("media", entry.media);
		assertEquals("media:content url", "http://lh5.ggpht.com/_7xTZSmvyUmQ/SOqCc0K_DzI/AAAAAAAACJY/AUgV83nbi9E/33880006.jpg", entry.media.content.url);
		assertEquals("media:content type", "image/jpeg", entry.media.content.type);
		assertEquals("media:content medium", "image", entry.media.content.medium);
		assertEquals("media:content width ", 800, entry.media.content.width);
		assertEquals("media:content height", 800, entry.media.content.height);
		assertTrue("media:content fileSize", isNaN(entry.media.content.fileSize));
		assertEquals("media:credit", "Pink-fu", entry.media.credit);
		assertEquals("media:description", "Lomography.sk workshop 10/2007 / Jednota", entry.media.description);
		
		assertTrue("media:keywords is array", entry.media.keywords is Array);
		assertEquals("media:keywords length", 2, entry.media.keywords.length);
		assertEquals("media:keywords 0", "diana", entry.media.keywords[0]);
		assertEquals("media:keywords 1", "blog_post_01", entry.media.keywords[1]);
		
		assertTrue("media:thumbnails", entry.media.thumbnails is Array);
		assertEquals("media:thumbnails has 3 elements", 3, entry.media.thumbnails.length);
		
		assertEquals("media:thumbnail url", "http://lh5.ggpht.com/_7xTZSmvyUmQ/SOqCc0K_DzI/AAAAAAAACJY/AUgV83nbi9E/s72/33880006.jpg", entry.media.thumbnail.url);
		assertEquals("media:thumbnail width", 72, entry.media.thumbnail.width);
		assertEquals("media:thumbnail height", 72, entry.media.thumbnail.height);
		
		assertEquals("media:thumbnails[1] url", "http://lh5.ggpht.com/_7xTZSmvyUmQ/SOqCc0K_DzI/AAAAAAAACJY/AUgV83nbi9E/s144/33880006.jpg", entry.media.thumbnails[1].url);
		assertEquals("media:thumbnails[1] width", 144, entry.media.thumbnails[1].width);
		assertEquals("media:thumbnails[1] height", 144, entry.media.thumbnails[1].height);
		
		assertEquals("media:thumbnails[2] url", "http://lh5.ggpht.com/_7xTZSmvyUmQ/SOqCc0K_DzI/AAAAAAAACJY/AUgV83nbi9E/s288/33880006.jpg", entry.media.thumbnails[2].url);
		assertEquals("media:thumbnails[2] width", 288, entry.media.thumbnails[2].width);
		assertEquals("media:thumbnails[2] height", 288, entry.media.thumbnails[2].height);
		
		assertEquals("media:title", "33880006.jpg", entry.media.title);
		
		// georss
		// todo: needs to add Envelope and test it
		assertNotNull("georss:where", entry.geo);
		assertEquals("latitude", "48.148376", entry.geo.latitude);
		assertEquals("longitude", "17.1073099", entry.geo.longitude);	
	}
}
}
