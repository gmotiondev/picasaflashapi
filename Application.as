/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClip
{
	private function Application(mc:MovieClip)
	{
		PicasaTestRunner.process();
	}

	public static function main(mc:MovieClip) : Void
	{
		var o:Application = new Application(mc);
	}
}