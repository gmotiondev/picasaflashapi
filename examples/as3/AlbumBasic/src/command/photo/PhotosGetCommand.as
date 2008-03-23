package command.photo 
{
	import control.InitializeEvent;	
	
	import com.bourre.events.EventBroadcaster;	
	
	import model.ModelList;	
	
	import com.bourre.model.ModelLocator;	
	
	import model.ModelApplication;	
	
	import sk.prasa.webapis.picasa.Photo;	
	import sk.prasa.webapis.picasa.PicasaError;	
	
	import flash.events.Event;
	
	import command.IDelegateReceiver;
	import business.PhotosDelegate;
	import control.photo.PhotosGetEvent;

	import com.bourre.commands.Command;
	import com.bourre.commands.AbstractCommand;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotosGetCommand extends AbstractCommand implements Command, IDelegateReceiver
	{
		private var __model : ModelApplication;

		override public function execute(evt : Event = null) : void
		{
			__model = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION));
			
			var tDelegate : PhotosDelegate = new PhotosDelegate(this);
				tDelegate.list((evt as PhotosGetEvent).userid, (evt as PhotosGetEvent).albumid);
		}
		
		public function result(data : Object) : void
		{
			for each(var item : Photo in data)
			{
				__model.photos.addItem(item);
			}
			
			EventBroadcaster.getInstance().broadcastEvent(new InitializeEvent());
		}

		public function fault(e : PicasaError) : void
		{
			trace("Error: " + e.message);
		}
	}
}
