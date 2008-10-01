import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.*;

import model.*;

/**
 * @author Michal Gron
 */
class command.ResizeCommand implements Command
{	
	private var __model : ModelApplication;

	public function execute(evt : ResizeEvent) : Void
	{
		__model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		__model.notifyChanged(evt);
	}
}
