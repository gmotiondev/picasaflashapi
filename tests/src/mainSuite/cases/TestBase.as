package mainSuite.cases 
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.PicasaService;

import mx.core.Application;

import flash.filesystem.File;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
public class TestBase extends TestCase 
{
	private var __fixtures_path : String; 
	
	// todo: we need a method to specify the feed_api location. if it remote, its
	//		 ok, else if it's local, try to not add parameters with ?mar_results=1000 etc
	
	public function get fixtures_path() : String
	{
		return __fixtures_path;
	}
	
	public function set fixtures_path(path : String) : void
	{
		if(path != null)
		{
			var tAppUrl : String = (new File(Application.application.url).parent).nativePath;
			var tFolder : Array = tAppUrl.split("/");
				tFolder.pop();
				tFolder.unshift("file:/");
	
			__fixtures_path = "" + tFolder.concat(path).join(File.separator);
			trace("FIXTURES PATH:", __fixtures_path);
			PicasaService.FEED_API_URL = __fixtures_path;
		}
		else
		{
			PicasaService.FEED_API_URL = "http://photos.googleapis.com/data/feed/api/";
		}
	}
}
}
