import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

class command.SlideShowStartCommand implements Command
{
	private var model:ModelApplication; 
	
	// 
	public function execute(e:SlideShowStartEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.start();
	}
}