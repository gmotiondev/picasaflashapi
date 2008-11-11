package sk.prasa.tumblr.model 
{
	import sk.prasa.tools.model.SimpleServiceProxy;	import sk.prasa.tools.model.vo.RequestVO;	import sk.prasa.tumblr.ApplicationFacade;	import sk.prasa.webapis.picasa.events.PicasaDataEvent;		import flash.events.ErrorEvent;	import flash.events.ProgressEvent;		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ServiceProxy extends SimpleServiceProxy
	{
		public static const DATA_EVENT : String = "data_Event";
		public static const ERROR_EVENT : String = "error_Event";
		
		public static const NAME : String = "ServiceProxy";
		
		public function ServiceProxy(data : Object = null)
		{
			super(NAME, data);
		}
		
		public function load() : void
		{
			// if the tag exists, prioritize the tag.. else simple albumid
			if(this.request.tag != null)		
			{
				this.getPhotosListByTag(this.request.userid, this.request.albumid, this.request.tag);
				
			} else
			{
				this.getPhotosList(this.request.userid, this.request.albumid);
			}
		}
		
		override protected function result(evt : PicasaDataEvent) : void
		{
			super.result(evt);
			
			this.sendNotification(DATA_EVENT, evt.data);
		}

		override protected function fault(evt : ErrorEvent) : void
		{
			super.fault(evt);
			
			this.sendNotification(ERROR_EVENT, evt.text);
		}
		
		override protected function progress(evt : ProgressEvent) : void
		{
			super.progress(evt);
			
			this.sendNotification(ApplicationFacade.PROGRESS_EVENT, 99);
		}
	}
}
