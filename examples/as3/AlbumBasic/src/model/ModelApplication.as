package model 
{
	import control.photo.PhotosGetEvent;	
	
	import com.bourre.events.EventBroadcaster;	
	
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;	
	
	import sk.prasa.webapis.picasa.PicasaService;	
	
	import com.bourre.plugin.Plugin;	
	import com.bourre.model.AbstractModel;	
	
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
			service = PicasaService.getInstance();
			
			service.imgmax = 320;
			service.thumbsize = 64;
			service.max_results = 24;
			
			service.addEventListener(IOErrorEvent.IO_ERROR, onServiceError);
			service.addEventListener(ProgressEvent.PROGRESS, onServiceProgress);
			
			EventBroadcaster.getInstance().broadcastEvent(new PhotosGetEvent(USERID, ALBUMID));
		}

		public function next() : void
		{ 
			//var tId : String = photos.getNext();
			//var tTitle : String = photos.getCurrentTitle();
			
			//notifyChanged(new PhotoChangedEvent(tId, tTitle));
		}
		
		public function prev() : void
		{
			//var tId : String = photos.getPrevious();
			//var tTitle : String = photos.getCurrentTitle();
			
			//notifyChanged(new PhotoChangedEvent(tId, tTitle));
		}
		
		public function click(aId : String) : void
		{	
			//var tId : String = photos.getClicked(aId);
			//var tTitle : String = photos.getCurrentTitle();
			
			//notifyChanged(new PhotoChangedEvent(tId, tTitle));
		}
		
		private function onServiceError(evt : IOErrorEvent) : void
		{
			trace("onServiceError: " + evt);
		}
		
		private function onServiceProgress(evt : ProgressEvent) : void
		{
			trace("onServiceProgress: " + evt);
		}
	}
}
