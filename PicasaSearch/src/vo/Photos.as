import sk.prasa.mvc.vo.PhotosVO;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class vo.Photos extends PhotosVO
{	
	private static var __instance : Photos;

	private function Photos()
	{
	}

	public static function getInstance() : Photos
	{
		if(!__instance) __instance = new Photos();
		
		return __instance;
	}
}