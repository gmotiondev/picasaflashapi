import sk.prasa.webapis.picasa.tests.PicasaServiceTest;
import sk.prasa.webapis.picasa.tests.albums.*;
import sk.prasa.webapis.picasa.tests.comments.*;
import sk.prasa.webapis.picasa.tests.community.*;
import sk.prasa.webapis.picasa.tests.photos.*;
import sk.prasa.webapis.picasa.tests.tags.*;
class sk.prasa.webapis.picasa.tests.AllTests extends TestSuite
{
	private var className:String = "AllTests";

	public function AllTests()
	{
		super();
		
		addTest(new PicasaServiceTest());
		addTest(new AlbumsList());
		addTest(new PhotosListByTag());
		
		addTest(new CommentsUser());
		addTest(new CommentsAlbum());
		addTest(new CommentsPhoto());
		
		addTest(new TagsUser());
		addTest(new TagsAlbum());
		addTest(new TagsPhoto());

		addTest(new CommunitySearch());
		// addTest(new PicasaErrorTest());
		// addTest(new PicasaVOTest());
	}
}
