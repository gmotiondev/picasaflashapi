import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import business.*;

import command.*;

import control.*;

import model.*;

import sk.prasa.webapis.picasa.Album;
import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.InitializeAlbumsCommand implements Command, IResponder
{
	private var model:ModelApplication; 
	
	public function execute(evt:InitializeAlbumsEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var d : AlbumsDelegate = new AlbumsDelegate(this);
			d.list(evt.userid);
	}
	
	public function result(data:Array):Void
	{
		for(var a:Number = 0; a < data.length; a++)
		{
			var tAlbum : Album = data[a];
			model.albums.push(tAlbum);
			
//			var tEvent:SetAlbumThumbEvent = new SetAlbumThumbEvent(
//				tAlbum.gphoto.id,
//				tAlbum.media.thumbnail[0].url,
//				tAlbum.media.thumbnail[0].width,
//				tAlbum.media.thumbnail[0].height,
//				a,
//				data.length
//			);
//			
//			EventBroadcaster.getInstance().dispatchEvent(tEvent);
		}
		
		EventBroadcaster.getInstance().broadcastEvent(new SetAlbumsThumbEvent());
	}

	public function fault(error:PicasaError):Void
	{
		trace("InitializeAlbumsCommand failed: "+error.message);
	}
}