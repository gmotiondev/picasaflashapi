/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.PhotoClickEvent;

class command.PhotoClickCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(evt:PhotoClickEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.click(evt.id);
	}

}