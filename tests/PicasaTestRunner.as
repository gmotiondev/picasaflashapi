import asunit.textui.TestRunner;
import sk.prasa.webapis.picasa.tests.AllTests;

class PicasaTestRunner extends TestRunner
{
	public function PicasaTestRunner()
	{
		start(AllTests);
	}

	public static function process():Void
	{
		var runner:TestRunner = new PicasaTestRunner();
	}
}