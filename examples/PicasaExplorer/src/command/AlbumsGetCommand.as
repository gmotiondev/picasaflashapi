/**
 *
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.BasicEvent;

import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.Album;

import command.IResponder;
import business.*;
import control.*;
import model.*;

import vo.Albums;

class command.AlbumsGetCommand implements Command, IResponder
{
	private var model:ModelApplication;
	
	public function execute(e:AlbumsGetEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tUserid:String = e.userid;
		
		var d:AlbumsDelegate = new AlbumsDelegate(this);
			d.list(tUserid);
	}
	
	public function result(data:Array):Void
	{
		var tAlbums:Albums = new Albums();
		for(var a:Number = 0; a < data.length; a++)
		{
			var tAlbum:Album = data[a];
				tAlbums.push(tAlbum);
		}
		model.dispatch_change("albums", tAlbums);
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("AlbumsGetCommand.fault!");
	}
}