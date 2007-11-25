/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

import model.*;
import business.*;
import command.IResponder;
import control.InitializeEvent;
import control.GetPhotosEvent;

class command.GetPhotosCommand implements Command, IResponder
{
	private var model:ModelApplication; 
	
	public function execute(e:GetPhotosEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tQuery:String = e.query;
		var d:PhotosDelegate = new PhotosDelegate(this);
			d.search(tQuery);
	}
	
	public function result(data:Array):Void
	{
		model.photos.init();
		trace("found "+data.length+" images.");
		for(var a:Number = 0; a < data.length; a++)
		{
			var tPhoto:Photo = data[a];
			model.photos.push(tPhoto);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new InitializeEvent());
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("PhotosGetCommand failed: "+error.message);
	}
}