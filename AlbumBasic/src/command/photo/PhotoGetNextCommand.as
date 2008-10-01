import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.photo.PhotoGetNextEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.photo.PhotoGetNextCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : PhotoGetNextEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.next();
	}
}