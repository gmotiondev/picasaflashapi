import model.ModelList;

import com.bourre.core.Model;

import control.ProgressEvent;

import model.ModelApplication;

import com.bourre.commands.Command;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.ProgressCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : ProgressEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}
