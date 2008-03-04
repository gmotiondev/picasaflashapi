import com.bourre.events.IEvent;
import com.bourre.core.Model;
import com.bourre.commands.Command;

import model.*;
import control.ThumbClickEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.ThumbClickCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : ThumbClickEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
		
		if(model.photos.getCurrentId() != evt.id)
		{
			model.click(evt.id);
		}
	}
}