import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.ResizeEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.ResizeCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : ResizeEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}