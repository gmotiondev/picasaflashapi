import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.*;
import model.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.GetPrevPhotoCommand implements Command
{
	private var model : ModelApplication; 
 
	public function execute(evt : GetPrevPhotoEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.prev();
	}
}