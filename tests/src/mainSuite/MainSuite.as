package mainSuite 
{
	import mainSuite.cases.commands.TestFeatured;
import mainSuite.cases.objects.TestUtils;
import mainSuite.cases.objects.feed.TestAlbumEntry;
import mainSuite.cases.objects.feed.TestAlbumMeta;
import mainSuite.cases.objects.feed.TestAtomFeed;
import mainSuite.cases.objects.feed.TestCommentEntry;
import mainSuite.cases.objects.feed.TestEntry;
import mainSuite.cases.objects.feed.TestMeta;
import mainSuite.cases.objects.feed.TestPhotoEntry;
import mainSuite.cases.objects.feed.TestPhotoMeta;
import mainSuite.cases.objects.feed.TestTagEntry;
import mainSuite.cases.objects.feed.TestUserEntry;
import mainSuite.cases.objects.feed.TestUserMeta;

import net.digitalprimates.fluint.tests.TestSuite;
/**
 * 
 */
public class MainSuite extends TestSuite 
{
	public function MainSuite()
	{
		super();
		// utils
		addTestCase(new TestUtils());
		// abstract type
		addTestCase(new TestAtomFeed());
		
		// metas
		addTestCase(new TestMeta());
		addTestCase(new TestAlbumMeta());
		addTestCase(new TestPhotoMeta());
		addTestCase(new TestUserMeta());
		
		// entries
		addTestCase(new TestEntry());
		addTestCase(new TestAlbumEntry());
		addTestCase(new TestCommentEntry());
		addTestCase(new TestPhotoEntry());
		addTestCase(new TestTagEntry());
		addTestCase(new TestUserEntry());
		
		// commands
		//addTestCase(new TestFeatured());
		
		// main service
		//addTestCase(new TestService());
	}
}
}