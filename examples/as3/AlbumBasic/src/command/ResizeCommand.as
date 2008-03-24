package command 
{
	import flash.events.Event;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.model.ModelLocator;
	
	import model.ModelApplication;
	import model.ModelList;		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class ResizeCommand extends AbstractCommand implements Command 
	{
		override public function execute(evt : Event = null) : void
		{
			var tModel : ModelApplication = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION));
				tModel.notifyChanged(evt);
		}
	}
}
