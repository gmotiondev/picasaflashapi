import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.mvc.command.IResponder;

import model.*;
import control.*;
import control.photo.*;
import business.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.photo.PhotosGetCommand implements Command, IResponder
{
	private var model : ModelApplication; 
	
	public function execute(evt : PhotosGetEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tUserid : String = evt.userid;
		var tAlbumid : String = evt.albumid;
		
		var d : PhotosDelegate = new PhotosDelegate(this);
			d.list(tUserid, tAlbumid);
	}
	
	public function result(data : Array) : Void
	{
		for(var a : Number = 0; a < data.length; a++)
		{
			var tPhoto : Photo = data[a];
			model.photos.push(tPhoto);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new InitializeEvent());
	}
	
	public function fault(error : PicasaError) : Void
	{
		trace("PhotosGetCommand failed: "+error.message);
	}
}