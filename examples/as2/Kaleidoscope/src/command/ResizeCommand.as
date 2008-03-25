/**
 * @author Michal Gron
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

class command.ResizeCommand implements Command
{	
	public function execute(evt:ResizeEvent):Void
	{
		ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).onResize();
	}
}