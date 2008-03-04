import com.bourre.events.IEvent;

import business.*;
import control.*;
import command.IResponder;
import model.*;

import com.bourre.core.Model;
import com.bourre.commands.Command;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.GetAlbumCommand implements Command, IResponder
{
	private var model : ModelApplication;

	public function execute(evt : GetAlbumEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var d : PhotosDelegate = new PhotosDelegate(this);
		d.list(evt.userid, evt.albumid);
	}
	
	public function result(data : Array) : Void
	{
		for(var a : Number = 0; a < data.length; a++)
		{
			var tPhoto : Photo = data[a];
			model.photos.push(tPhoto);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new LoadThumbsEvent());
	}
	
	public function fault(error : PicasaError) : Void
	{
		trace("PhotosGetCommand failed: "+error.message);
	}
}
