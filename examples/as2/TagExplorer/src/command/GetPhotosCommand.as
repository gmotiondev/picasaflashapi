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
import control.SetPhotosEvent;

class command.GetPhotosCommand implements Command, IResponder
{
	private var model:ModelApplication; 
	
	public function execute(event:GetPhotosEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		if(event.hasChanged)
		{
			model.service.start_index = 1;
		}
		
		var tTag:String = escape(event.tag);
		
		var d:PhotosDelegate = new PhotosDelegate(this);
			d.list(model.userid, tTag);
	}
	
	public function result(data:Array):Void
	{
		model.photos.init();
		
		for(var a:Number = 0; a < data.length; a++)
		{
			var tPhoto:Photo = data[a];
			model.photos.push(tPhoto);
		}
		
		var tTotalResults:Number = model.photos[0].parent.opensearch.totalResults;
		var tItemsPerPage:Number = model.photos[0].parent.opensearch.itemsPerPage;
		trace("total: " + tTotalResults + ", per page: " + tItemsPerPage);
		EventBroadcaster.getInstance().dispatchEvent(new SetPhotosEvent(tTotalResults, tItemsPerPage));
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("GetPhotosCommand failed: "+error.message);
	}
}