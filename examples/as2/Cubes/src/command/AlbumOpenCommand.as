import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.AlbumOpenEvent;

import model.ModelApplication;
import model.ModelList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.AlbumOpenCommand implements Command
{
	private var __model : ModelApplication;

	public function execute(evt : AlbumOpenEvent) : Void
	{
		__model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		__model.notifyChanged(evt);
	}
}
