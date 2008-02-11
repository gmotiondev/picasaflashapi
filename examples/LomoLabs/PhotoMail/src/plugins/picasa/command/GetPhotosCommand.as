/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;

import plugins.picasa.control.GetPhotosEvent;
import plugins.picasa.model.*;

class plugins.picasa.command.GetPhotosCommand extends AbstractCommand
{
	public function execute(evt:GetPhotosEvent)
	{
		var tModel = PicasaModel(getModelLocator().getModel(ModelList.PICASA_MODEL));
		// new business..
		trace("GetPhotosEvent with callback on "+evt.callback+" channel, user: "+evt.user+", album: "+evt.album);
	}

}