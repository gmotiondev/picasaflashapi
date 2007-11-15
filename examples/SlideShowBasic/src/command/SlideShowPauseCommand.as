import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

class command.SlideShowPauseCommand implements Command
{
	private var model:ModelApplication; 
	
	// 
	public function execute(e:SlideShowPauseEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.pause(SlideShowPauseEvent(e).force);
	}
}