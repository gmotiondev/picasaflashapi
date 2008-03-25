/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.ScreenResizeEvent;

class command.ScreenResizeCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(event:ScreenResizeEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.onScreenResize(event);
	}
}