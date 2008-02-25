/**
 * @author michal.gron@gmail.com
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.ProgressSetEvent;

class command.ProgressSetCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(evt:ProgressSetEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}