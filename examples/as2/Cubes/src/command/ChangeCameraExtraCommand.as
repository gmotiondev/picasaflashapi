import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.ChangeCameraExtraEvent;

import model.ModelApplication;
import model.ModelList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.ChangeCameraExtraCommand implements Command
{
	private var __model : ModelApplication;

	public function execute(evt : ChangeCameraExtraEvent) : Void
	{
		__model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		__model.notifyChanged(evt);
	}
}
