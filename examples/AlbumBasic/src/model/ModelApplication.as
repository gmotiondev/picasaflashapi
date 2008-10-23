package model 
{
	import com.bourre.events.EventBroadcaster;
	import com.bourre.model.AbstractModel;
	import com.bourre.plugin.Plugin;

	import control.photo.PhotoChangedEvent;
	import control.photo.PhotosGetEvent;

	import sk.prasa.webapis.picasa.PicasaService;

	import vo.Photos;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class ModelApplication extends AbstractModel 
	{
		public var photos : Photos;
		public var service : PicasaService;

		public static var USERID : String = "thisispinkfu";
		public static var ALBUMID : String = "5094406297232552993";

		public function ModelApplication(owner : Plugin = null)
		{
			super(owner, ModelList.MODEL_APPLICATION);
		}

		public function initialize() : void
		{
			photos = new Photos();
			service = new PicasaService();
			service.imgmax = "320";
			service.thumbsize = "64";
			service.max_results = 24;
			
			EventBroadcaster.getInstance().broadcastEvent(new PhotosGetEvent(USERID, ALBUMID));
		}

		public function next() : void
		{ 
			var tId : String = photos.getNext();
			var tTitle : String = photos.getCurrentTitle();
			var tUrl : String = photos.getCurrentUrl();
			
			notifyChanged(new PhotoChangedEvent(tId, tTitle, tUrl));
		}

		public function prev() : void
		{
			var tId : String = photos.getPrevious();
			var tTitle : String = photos.getCurrentTitle();
			var tUrl : String = photos.getCurrentUrl();
			
			notifyChanged(new PhotoChangedEvent(tId, tTitle, tUrl));
		}

		public function click(aId : String) : void
		{
			var tId : String = photos.setCurrent(aId);
			var tTitle : String = photos.getCurrentTitle();
			var tUrl : String = photos.getCurrentUrl();
			
			notifyChanged(new PhotoChangedEvent(tId, tTitle, tUrl));
		}
	}
}
