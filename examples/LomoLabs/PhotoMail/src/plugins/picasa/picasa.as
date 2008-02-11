/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;
import com.bourre.events.IEvent;

import plugins.picasa.control.*;
import plugins.picasa.model.*;

class plugins.picasa.picasa extends AbstractPlugin
{
	public function picasa()
	{
		super();
		
		initialize();
	}
	
	private function initialize():Void
	{
		trace("picasa up and running!");
		
		Controller.getInstance(this).initialize();
		
		var tModel:PicasaModel = new PicasaModel(this, ModelList.PICASA_MODEL);
		// tModel.addListener ...
	}
	
	public function getPhotosEvent(evt:IEvent):Void
	{
		var tObj:Object = evt.getTarget();
		firePrivateEvent(new GetPhotosEvent(tObj.callback, tObj.user, tObj.album));
	}
}