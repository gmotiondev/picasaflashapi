/**
 *
 */

import com.bourre.commands.Command;
import com.bourre.core.Model;

import sk.prasa.webapis.picasa.PicasaError;

import command.IResponder;
import business.*;
import control.*;
import model.*;

class command.AlbumsGetCommand implements Command, IResponder
{
	private var model:ModelApplication;
	
	public function execute(e:AlbumsGetEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tUserid:String = e.userid;
		
		var d:AlbumsDelegate = new AlbumsDelegate(this);
			d.list(tUserid);
			
		trace("AlbumsGetCommand.execute("+tUserid+")");
		
		
	}
	
	public function result(data:Array):Void
	{
		trace("AlbumsGetCommand.result")
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("AlbumsGetCommand.fault: ");
	}
}