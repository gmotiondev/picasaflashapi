package command.photo 
{
	import flash.events.Event;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.model.ModelLocator;
	
	import business.PhotosDelegate;
	
	import command.IDelegateReceiver;
	
	import control.InitializeEvent;
	import control.photo.PhotosGetEvent;
	
	import model.ModelApplication;
	import model.ModelList;
	
	import sk.prasa.webapis.picasa.Photo;
	import sk.prasa.webapis.picasa.PicasaError;		
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
				__model.photos.push(item);
			}
			
			EventBroadcaster.getInstance().broadcastEvent(new InitializeEvent());
		}

		public function fault(e : PicasaError) : void
		{
			trace("Error: " + e.message);
		}
	}
}