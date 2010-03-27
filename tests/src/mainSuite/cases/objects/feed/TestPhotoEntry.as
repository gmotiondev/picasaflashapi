package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.Kind;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestPhotoEntry extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "assets/fixtures/feed/api/";
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.photos.list("thisispinkfu", "5161355527636525521");
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
		// TODO: bug? /api/ missing from url? 
		var ids : Array = [
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155275625626978",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155304427820978",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155346833772338",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155398100363794",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155431569781746",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812366159520530",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812568936226658",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812766579130034",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812485562720770",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812664942158786",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271812870102866514",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683210567598706",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683242449763394",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683261149703650",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683276714901634",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217391880600263298",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392183592004978",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392146699666178",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392163582417250",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683291183481698",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683308968618098",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217391952786176050",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392004053071938",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392068552042034",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392100420050226",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5217392127868203042",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683406362096738",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683454378807106",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683478170011122",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5216683514058800018",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5229659105382561122",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5229659133480155874",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5229659167690392050",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5229659192409934466",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5229659212030031842",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5237616419711686322",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5237616450862803138",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5237616477328320594",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5237616502037479202",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5237616538172872786",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271808299839488930",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271808497071087026",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271808670941106370",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271808797307752818",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271808982219180466",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271809165769043362",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271809372647416530",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5271809756359376578",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5299417786936044578",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5299417912916261650",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5299418020081737010",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5299418133657819858",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300442138830166050",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300442285558283042",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300442397058357938",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300442616496015042",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300442820951412418",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5300443011577316962",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318003101295094690",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318003307029678098",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318003498131476690",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318003591992953474",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318003749449632498",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5318004084853717474",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5336531000317054402",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5337641095274882018",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5337641185596139490",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349476022756098242",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349476221322846290",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349476403467651794",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349476606679647746",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349498401641695026",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349717333484049714",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5349717985267596034",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5350386080732047570",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5350386239042447170",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5350386489872333810",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351011760990167986",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351011860463417666",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351011965533450274",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351012088813764514",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351012198792112754",
			"http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5351012367070767570"
		];
		
		var entry : PhotoEntry;
		
		for(var a : int = 0; a < atom.entries.length; a++)
		{
			entry = atom.entries[a] as PhotoEntry;
			assertEquals(ids[a], entry.id);
		}
	}
	
	public function testEntry() : void
	{
		var entry : PhotoEntry = atom.entries[1];	// this is the Ljubljana entry
		
		// title
		assertEquals("33880005.jpg", entry.title);
		
		// links
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_FEED).type);
		assertEquals("rel_feed", "http://photos.googleapis.com/data/feed/api/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155304427820978?v=2", entry.links.find_by_rel(Link.REL_FEED).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_ALTERNATE).type);
		assertEquals("http://picasaweb.google.com/thisispinkfu/Diana#5254155304427820978", entry.links.find_by_rel(Link.REL_ALTERNATE).href);
		
		assertEquals("application/atom+xml", entry.links.find_by_rel(Link.REL_SELF).type);
		assertEquals("rel_self", "http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155304427820978?v=2", entry.links.find_by_rel(Link.REL_SELF).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_CANONICAL).type);
		assertEquals("http://picasaweb.google.com/lh/photo/u43JYJJmxiSGvlNfA24Ydg", entry.links.find_by_rel(Link.REL_CANONICAL).href);
		
		assertEquals("text/html", entry.links.find_by_rel(Link.REL_REPORT_ABUSE).type);
		assertEquals("http://picasaweb.google.com/lh/reportAbuse?uname=thisispinkfu&aid=5161355527636525521&iid=5254155304427820978", entry.links.find_by_rel(Link.REL_REPORT_ABUSE).href);
		
		// authors
		assertNotNull("author", 0, entry.author);
		assertNull("author.email", entry.author.email);
		assertNull("author.name", entry.author.name);
		assertNull("author.uri", entry.author.uri);
				
		// content
		assertNotNull(entry.content);
		assertEquals("content src", "http://lh3.ggpht.com/_7xTZSmvyUmQ/SOqCaWMnl7I/AAAAAAAACJQ/xNt6QGnAX2k/33880005.jpg", entry.content.src);
		assertNull("content value", entry.content.value); // todo: should be the same as src when photoentry?
		assertEquals("content type", "image/jpeg", entry.content.type);
		
		// categories
		assertEquals("category scheme", "http://schemas.google.com/g/2005#kind", entry.category.scheme);
		assertEquals("category term", Kind.PHOTO, entry.category.term);
		assertNull("category label", entry.category.label);
		
		// id
		// TODO: bug? /api/ missing?
		// was: http://photos.googleapis.com/data/entry/api/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155304427820978
		assertEquals("http://photos.googleapis.com/data/entry/user/thisispinkfu/albumid/5161355527636525521/photoid/5254155304427820978", entry.id);
		
		// published 2008-10-06T21:26:01.000Z
		assertEquals("published value", "Mon Oct 6 21:26:01 2008 UTC", entry.published.toUTCString());
		
		// updated 2009-06-25T07:17:22.091Z
		assertEquals("updated value", "Thu Jun 25 07:17:22 2009 UTC", entry.updated.toUTCString());
		
		// summary
		assertEquals("Lomography.sk workshop 10/2007 / Tram", entry.summary);
		
		// rights
		assertNull("rights.value is null", entry.rights);
		assertNull("rights.type is null", entry.rights);
		
		
		// gphoto
		assertEquals("gphoto:kind", Kind.PHOTO, entry.gphoto.kind);
		assertEquals("gphoto:albumid", "5161355527636525521", entry.gphoto.albumid);	// valid only with the photo and comment type!
		assertEquals("gphoto:id", "5254155304427820978", entry.gphoto.id);
	
		assertNotNull("gphoto", entry.gphoto);
		assertEquals("gphoto:checksum", "a653fdf", entry.gphoto.checksum);
		assertEquals("gphoto:commentCount", 0, entry.gphoto.commentCount);
		assertEquals("gphoto:height", 846, entry.gphoto.height);
		assertEquals("gphoto:rotation", 0, entry.gphoto.rotation);
		assertEquals("gphoto:size", 204132, entry.gphoto.size);
		assertEquals("gphoto:timestamp", 1223148040000, entry.gphoto.timestamp);
		assertNull("gphoto:videostatus", entry.gphoto.videostatus);
		assertEquals("gphoto:width", 800, entry.gphoto.width);
		

		// photo entries search result feed
		assertNull(entry.gphoto.albumtitle);
		assertNull(entry.gphoto.albumdesc);
		assertNull(entry.gphoto.snippet);
		assertNull(entry.gphoto.snippettype);
		assertFalse(entry.gphoto.truncated);
		
		/*
		 	Some extra stuff we need to identify agains API reference!
			<gphoto:version>6</gphoto:version>
			<gphoto:position>1.88</gphoto:position>
			<gphoto:access>public</gphoto:access>
			<gphoto:client>picasa</gphoto:client>
			<gphoto:imageVersion>2196</gphoto:imageVersion>
		*/
		
		// exif
		assertNotNull("exif exists", entry.exif);
		assertEquals("exif:make", "NORITSU KOKI", entry.exif.make);
		assertEquals("exif:model", "QSS-32_33", entry.exif.model);
		assertEquals("exif:imageUniqueID", "c570fa05f21cb68f20fd0698754f6ba0", entry.exif.imageUniqueID);
		assertTrue("exif:distance", isNaN(entry.exif.distance));
		assertTrue("exif:exposure", isNaN(entry.exif.exposure));
		assertFalse("exif:flash", entry.exif.flash);
		
		assertTrue("exif:focallength", isNaN(entry.exif.focallength));
		assertTrue("exif:fstop", isNaN(entry.exif.fstop));
		assertTrue("exif:iso", isNaN(entry.exif.iso));
		assertTrue("exif:time", isNaN(entry.exif.time));
		
		// media
		assertNotNull("media", entry.media);
		assertEquals("media:content url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/SOqCaWMnl7I/AAAAAAAACJQ/xNt6QGnAX2k/33880005.jpg", entry.media.content.url);
		assertEquals("media:content type", "image/jpeg", entry.media.content.type);
		assertEquals("media:content medium", "image", entry.media.content.medium);
		assertEquals("media:content width ", 800, entry.media.content.width);
		assertEquals("media:content height", 846, entry.media.content.height);
		assertTrue("media:content fileSize", isNaN(entry.media.content.fileSize));
		assertEquals("media:credit", "Pink-fu", entry.media.credit);
		assertEquals("media:description", "Lomography.sk workshop 10/2007 / Tram", entry.media.description);
		
		assertTrue("media:keywords is array", entry.media.keywords is Array);
		assertEquals("media:keywords length", 2, entry.media.keywords.length);
		assertEquals("media:keywords 0", "diana", entry.media.keywords[0]);
		assertEquals("media:keywords 1", "blog_post_01", entry.media.keywords[1]);
		
		assertTrue("media:thumbnails", entry.media.thumbnails is Array);
		assertEquals("media:thumbnails has 3 elements", 3, entry.media.thumbnails.length);
		
		assertEquals("media:thumbnails[0] url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/SOqCaWMnl7I/AAAAAAAACJQ/xNt6QGnAX2k/s72/33880005.jpg", entry.media.thumbnail.url);
		assertEquals("media:thumbnails[0] width", 69, entry.media.thumbnail.width);
		assertEquals("media:thumbnails[0] height", 72, entry.media.thumbnail.height);
		
		assertEquals("media:thumbnails[1] url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/SOqCaWMnl7I/AAAAAAAACJQ/xNt6QGnAX2k/s144/33880005.jpg", entry.media.thumbnails[1].url);
		assertEquals("media:thumbnails[1] width", 137, entry.media.thumbnails[1].width);
		assertEquals("media:thumbnails[1] height", 144, entry.media.thumbnails[1].height);
		
		assertEquals("media:thumbnails[2] url", "http://lh3.ggpht.com/_7xTZSmvyUmQ/SOqCaWMnl7I/AAAAAAAACJQ/xNt6QGnAX2k/s288/33880005.jpg", entry.media.thumbnails[2].url);
		assertEquals("media:thumbnails[2] width", 273, entry.media.thumbnails[2].width);
		assertEquals("media:thumbnails[2] height", 288, entry.media.thumbnails[2].height);
		
		assertEquals("media:title", "33880005.jpg", entry.media.title);
			
		// georss
		// todo: needs to add Envelope and test it
		assertNotNull("georss:where", entry.geo);
		assertEquals("latitude", "48.148376", entry.geo.latitude);
		assertEquals("longitude", "17.1073099", entry.geo.longitude);
	}
}
}