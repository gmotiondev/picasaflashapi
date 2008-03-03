import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.PhotoGetPrevCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : PhotoGetPrevEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.prev();
	}
}