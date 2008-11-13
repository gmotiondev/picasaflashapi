package sk.prasa.tumblr.model 
{
	import flash.events.ErrorEvent;	import flash.events.ProgressEvent;		import sk.prasa.tools.model.SimpleServiceProxy;	import sk.prasa.tumblr.ApplicationFacade;	import sk.prasa.webapis.picasa.events.PicasaDataEvent;		
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
			if(!this.request.userid)
			{
				this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, "UserID is missing!");
				
				return;
			}
			
			if(this.request.albumid != null && this.request.tag != null)
			{
				// search tag in album
				this.getPhotosListByTag(this.request.userid, this.request.albumid, this.request.tag);
				
			} else if(this.request.albumid == null && this.request.tag != null)
			{
				// search tag in albumS
				this.getListByTag(this.request.userid, this.request.tag);
				
			} else if(this.request.albumid != null && this.request.tag == null)
			{
				// simple album list
				this.getPhotosList(this.request.userid, this.request.albumid);
				
			} else
			{
				// don't know what to do!
				this.sendNotification(ApplicationFacade.TITLE_CHANGE_EVENT, "Yes, my Lord?");
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
