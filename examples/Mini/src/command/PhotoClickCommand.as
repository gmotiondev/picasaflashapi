import com.bourre.events.IEvent;
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.PhotoClickEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.PhotoClickCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : PhotoClickEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}