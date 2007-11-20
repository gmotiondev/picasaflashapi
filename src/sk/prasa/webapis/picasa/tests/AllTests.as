import asunit.framework.TestSuite;
import sk.prasa.webapis.picasa.tests.PicasaServiceTest;

class sk.prasa.webapis.picasa.tests.AllTests extends TestSuite
{
	private var className:String = "AllTests";

	public function AllTests()
	{
		super();
		addTest(new PicasaServiceTest());
		// addTest(new PicasaErrorTest());
		// addTest(new PicasaVOTest());
	}
}
