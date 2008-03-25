import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.PhotoCloseEvent;

import model.ModelApplication;
import model.ModelList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.PhotoCloseCommand implements Command
{
	private var __model : ModelApplication;

	public function execute(evt : PhotoCloseEvent) : Void
	{
		__model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		__model.notifyChanged(evt);
	}
}
