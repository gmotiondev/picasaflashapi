import com.bourre.commands.Command;
import com.bourre.events.DynBasicEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.core.Model;

import model.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class commands.OnPrevPhoto implements Command
{	
	public function execute(e:DynBasicEvent):Void
	{
		ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).getPrevPhoto();
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}