import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.ProgressEvent;
import model.ModelApplication;
import model.ModelList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.ProgressCommand implements Command 
{
	private var model : ModelApplication; 

	public function execute(evt : ProgressEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}
