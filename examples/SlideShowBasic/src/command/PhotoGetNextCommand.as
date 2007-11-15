/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

class command.PhotoGetNextCommand implements Command
{
	private var model:ModelApplication; 
	
	// 
	public function execute(e:PhotoGetNextEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.next();
	}
}