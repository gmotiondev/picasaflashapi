import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import business.*;
import command.*;
import control.*;
import model.*;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.InitializeCommand implements Command, IResponder
{
	private var model : ModelApplication; 

	public function execute(evt : InitializeEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var d : PhotosDelegate = new PhotosDelegate(this);
			d.list(evt.userid, evt.tag);
	}

	public function result(data : Array) : Void
	{
		for(var a : Number = 0;a < data.length; a++)
		{
			var tPhoto : Photo = Photo(data[a]);
			model.photos.push(tPhoto);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new GetNextPhotoEvent());
	}

	public function fault(error : PicasaError) : Void
	{
		trace("InitializeCommand failed: " + error.message);
	}
}