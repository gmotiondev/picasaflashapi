import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.*;

/**
 * @author Michal Gron
 */
class command.ResizeCommand implements Command
{	
	public function execute(e:ResizeEvent):Void
	{
		ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).onResize();
	}
}