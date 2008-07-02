package atom 
{
	import flexunit.framework.TestCase;
	
	import sk.prasa.webapis.picasa.objects.Link;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
	import sk.prasa.webapis.picasa.objects.feed.Entry;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;
	import sk.prasa.webapis.picasa.objects.feed.Meta;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class AtomTest extends TestCase 
	{
		private var __atom : IAtom;

		public function AtomTest(methodName : String = null)
		{
			super(methodName);
		}

		override public function setUp() : void
		{
			__atom = new AtomFeed(ATOM_DOCUMENT);
		}

		public function metaTest() : void
		{
			var meta : Meta = Meta(__atom.meta);
            
			assertNotNull(meta);
			assertEquals("id", meta.id, "http://picasaweb.google.com/data/feed/api/user/thisispinkfu");
			assertEquals("updated", meta.updated.toUTCString(), "Fri Jun 13 20:57:34 2008 UTC");
			
			// Categories 
			var categories : Array = meta.categories;
			assertNotNull(categories);
			assertEquals("categories.length", categories.length, 1);
			assertEquals("categories.term", categories[0].term, "http://schemas.google.com/photos/2007#user");
			assertEquals("categories.scheme", categories[0].scheme, "http://schemas.google.com/g/2005#kind");
			assertNull("categories.label", categories[0].label);
			
			
			assertEquals("title.type", meta.title.type, "text");
			assertEquals("title.value", meta.title.value, "thisispinkfu");
			assertEquals("subtitle.type", meta.subtitle.type, "text");
			assertNull("subtitle.value", meta.subtitle.value);
			assertEquals("icon", meta.icon, "http://lh6.ggpht.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu.jpg");
			
			// Link
			var link : Link = meta.links[0];
			assertEquals("link.rel", link.rel, "alternate");
			assertEquals("link.type", link.type, "text/html");
			assertEquals("link.href", link.href, "http://picasaweb.google.com/thisispinkfu");		

			// Authors
			var authors : Array = meta.authors;
			assertNotNull(authors);
			assertEquals("authors.length", authors.length, 1);
			assertEquals("authors.name", authors[0].name, "Pink-fu");
			assertNull("authors.email", authors[0].email);
			assertEquals("authors.uri", authors[0].uri, "http://picasaweb.google.com/thisispinkfu");
			
			// Generator 
			assertEquals("generator.uri", meta.generator.uri, "http://picasaweb.google.com/");
			assertEquals("generator.version", meta.generator.version, "1.00");
			assertEquals("generator.value", meta.generator.value, "Picasaweb");
		}

		public function entriesTest() : void
		{
			var entries : Array = __atom.entries;
			
			assertNotNull(entries);
			assertEquals("entries.length", entries.length, 1);
			
			var entry : Entry = entries[0];
			assertEquals("id", entry.id, "http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5135047888133059345");
			assertEquals("published", entry.published.toUTCString(), "Sat Aug 11 14:38:51 2007 UTC");
			assertEquals("updated", entry.updated.toUTCString(), "Tue Nov 20 22:40:23 2007 UTC");
			assertEquals("entry.title", entry.title.value, "Kolotoče");
			assertNull("entry.summary", entry.summary);

			// Categories 
			var categories : Array = entry.categories;
			assertNotNull(categories);
			assertEquals("categories.length", categories.length, 1);
			assertEquals("categories.term", categories[0].term, "http://schemas.google.com/photos/2007#album");
			assertEquals("categories.scheme", categories[0].scheme, "http://schemas.google.com/g/2005#kind");
			assertNull("categories.label", categories[0].label);
		
			// Links
			var links : Array = entry.links;
			assertNotNull(links);
			assertEquals("links.length", links.length, 1);
			
			var link : Link = links[0];
			assertEquals("link.rel", link.rel, "alternate");
			assertEquals("link.type", link.type, "text/html");
			assertEquals("link.href", link.href, "http://picasaweb.google.com/thisispinkfu/KolotoE");

			// Authors
			var authors : Array = entry.authors;

			assertNotNull(authors);
			assertEquals("authors.length", authors.length, 1);
			assertEquals("authors.name", authors[0].name, "Pink-fu");
			assertEquals("authors.uri", authors[0].uri, "http://picasaweb.google.com/thisispinkfu");			
		}

		private const ATOM_DOCUMENT : XML =
			<feed xmlns="http://www.w3.org/2005/Atom">
				<id>http://picasaweb.google.com/data/feed/api/user/thisispinkfu</id>
				<updated>2008-06-13T20:57:34.535Z</updated>
				<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#user"/>
				<title type="text">thisispinkfu</title>
				<subtitle type="text"/>
				<icon>http://lh6.ggpht.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s64-c/thisispinkfu.jpg</icon>
				<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu"/>
				<author>
					<name>Pink-fu</name>
					<uri>http://picasaweb.google.com/thisispinkfu</uri>
				</author>
				<generator version="1.00" uri="http://picasaweb.google.com/">Picasaweb</generator>
				<entry>
					<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5135047888133059345</id>
					<published>2007-08-11T14:38:51.000Z</published>
					<updated>2007-11-20T22:40:23.000Z</updated>
					<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#album"/>
					<title type="text">Kolotoče</title>
					<summary type="text"/>
					<rights type="text">public</rights>
					<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/KolotoE"/>
					<author>
						<name>Pink-fu</name>
						<uri>http://picasaweb.google.com/thisispinkfu</uri>
					</author>
				</entry>
			</feed>;
	}
}
