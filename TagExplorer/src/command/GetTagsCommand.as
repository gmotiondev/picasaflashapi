/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.Tag;
import sk.prasa.webapis.picasa.PicasaError;

import model.*;
import business.*;
import command.IResponder;
import control.InitializeEvent;
import control.GetTagsEvent;

class command.GetTagsCommand implements Command, IResponder
{
	private var model:ModelApplication; 
	
	public function execute(event:GetTagsEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tUsername:String = event.username;
		var d:TagsDelegate = new TagsDelegate(this);
			d.list(tUsername);
	}
	
	public function result(data:Array):Void
	{
		model.tags.init();
		
		for(var a:Number = 0; a < data.length; a++)
		{
			var tTag:Tag = data[a];
			model.tags.push(tTag);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new InitializeEvent());
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("GetPhotosCommand failed: "+error.message);
	}
}